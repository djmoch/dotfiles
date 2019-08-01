#
# Example hooks file for urlwatch
#
# Copyright (c) 2008-2018 Thomas Perl <m@thp.io>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

import re

from urlwatch import filters
from urlwatch import jobs
from urlwatch import reporters

from bs4 import BeautifulSoup

#class CustomLoginJob(jobs.UrlJob):
#    """Custom login for my webpage"""
#
#    __kind__ = 'custom-login'
#    __required__ = ('username', 'password')
#
#    def retrieve(self, job_state):
#        return 'Would log in to {} with {} and {}\n'.format(self.url, self.username, self.password)


#class CaseFilter(filters.FilterBase):
#    """Custom filter for changing case, needs to be selected manually"""
#
#    __kind__ = 'case'
#
#    def filter(self, data, subfilter=None):
#        # The subfilter is specified using a colon, for example the "case"
#        # filter here can be specified as "case:upper" and "case:lower"
#
#        if subfilter is None:
#            subfilter = 'upper'
#
#        if subfilter == 'upper':
#            return data.upper()
#        elif subfilter == 'lower':
#            return data.lower()
#        else:
#            raise ValueError('Unknown case subfilter: %r' % (subfilter,))


#class IndentFilter(filters.FilterBase):
#    """Custom filter for indenting, needs to be selected manually"""
#
#    __kind__ = 'indent'
#
#    def filter(self, data, subfilter=None):
#        # The subfilter here is a number of characters to indent
#
#        if subfilter is None:
#            indent = 8
#        else:
#            indent = int(subfilter)
#
#        ret

class GitHubFilter(filters.FilterBase):
    """Search for new Github releases or tags"""
    __kind__ = 'github'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        releases = soup.select('div.release-header div.f1 a')

        if releases:
            results = [rel.text for rel in releases]
            return '\n'.join(results)

        else:
            fallback = soup.select('div.site')
            return '\n'.join([str(tag) for tag in fallback])

class GitLabTagFilter(filters.FilterBase):
    """Search for new Github releases or tags"""
    __kind__ = 'gitlabtag'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        releases = soup.select('a.ref-name')

        if releases:
            results = [rel.text for rel in releases]
            return '\n'.join(results)

        else:
            fallback = soup.select('div.site')
            return '\n'.join([str(tag) for tag in fallback])

class PyPIFilter(filters.FilterBase):
    """Search for new releases at pypi.python.org"""
    __kind__ = 'pypi'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        downloads = soup.select('table.list tr > td > span > a:nth-of-type(1)')
        if downloads:
            downloads = [dl.text for dl in downloads]
            return ''.join(downloads)
        else:
            return data

class PyPIOrgFilter(filters.FilterBase):
    """Search for new releases on PyPI (pypi.org)"""
    __kind__ = 'pypiorg'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        releases = soup.find_all('p', class_='release__version')
        if releases:
            releases = [rel.text for rel in releases]
            return ''.join(releases)
        else:
            return data

class CustomMatchUrlFilter(filters.AutoMatchFilter):
    # The AutoMatchFilter will apply automatically to all filters
    # that have the given properties set
    MATCH = {'url': 'http://example.org/'}

    def filter(self, data):
        return data.replace('foo', 'bar')

class CustomRegexMatchUrlFilter(filters.RegexMatchFilter):
    # Similar to AutoMatchFilter
    MATCH = {'url': re.compile('http://example.org/.*')}

    def filter(self, data):
        return data.replace('foo', 'bar')


class CustomTextFileReporter(reporters.TextReporter):
    """Custom reporter that writes the text-only report to a file"""

    __kind__ = 'custom_file'

    def submit(self):
        with open(self.config['filename'], 'w') as fp:
            fp.write('\n'.join(super().submit()))


class CustomHtmlFileReporter(reporters.HtmlReporter):
    """Custom reporter that writes the HTML report to a file"""

    __kind__ = 'custom_html'

    def submit(self):
        with open(self.config['filename'], 'w') as fp:
            fp.write('\n'.join(super().submit()))
