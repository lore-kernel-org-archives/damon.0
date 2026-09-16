Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE753DDAF7;
	Wed, 16 Sep 2026 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538240; cv=none; b=QemL1ICS0vHNURdo4WS7Y7yhDUwxip34H7VddezwkV/Y09z9GABahDgw+xCz6sAdP5VsP+U7xalCuv9cUCK74+o1sUZXW+pnEgpA/sxwtMlA5XQYK1c7O2mC2Hv2z29qd5+1U2FJwQL6ayzV9GpbgpTL2fXQlQDrLe13Em0BWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538240; c=relaxed/simple;
	bh=qR8fzXpgBz9DWPvv0UgtKTwPVJEESO+CHZAOb6aBuxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSpb4EWKEDw2htfpyhrqkjriibcXY6kn03xuUhcNKLpf2FGfI142mQHaRbkLc+tC7FCUPS2euspVEmSCeWHn4QIvb1Sm7ElqrSfB4Fq5CGmYS3TzAH21CMxebAZM+U+eq7kRPEEIFqZzvc43uBin8sskJnpoOloTyn3yp+MvCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfjbn/14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfjbn/14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AAF1F00893;
	Wed, 16 Sep 2026 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789538238;
	bh=m6SKrH4CseAWkOxTNnD7adA5OG5gHGdFDKDZV8MwdQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hfjbn/14ap3NphlFUGF122siXy5FCwFpEPoVLD/bkd+cBzcIjiKB6/MC5XRcHHUDE
	 BUE4Y8+QMyH1XCUvSJSf8eRGEfjMlCj9wnfBzVCwFXv3IwxFVMtGNTuAHgTBJe5pID
	 OEQI12RtTWQ0jmOWZeDg5lNVuxrA9jf6Ykbl8Z5puaZI/XWFlizjnsciuMt2Zezswm
	 EweQSqqGtp5HWk8w+BJ3a7A4GO0DotOvPw6wNEwfag0dnM/3DhqO5Dk/0n8lR3qJAi
	 sG+5atyvp3JADGHGrMHBXPGJvYivWpXwzTF9csYn4q23Zn7dnYeNgsS0Z5qUcu+u50
	 jXFEPammnloAg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Date: Tue, 15 Sep 2026 22:57:10 -0700
Message-ID: <20260916055711.24926-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915163928.9d6260f445d895429d115fd8@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Tue, 15 Sep 2026 16:39:28 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 15 Sep 2026 07:33:49 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Knowing whether a given memory is backed by a hugepage of specific size
> > is useful for efficient utilization of hugepages.  For easy monitoring
> > of the information, introduce a new data attribute probe filter type,
> > hugepage_size.  It works similar to the DAMOS filter of the same name.
> > It works for memory that is backed by a hugepage of a given size range.
> > 
> > Patch 1 introduces the new probe filter type to DAMON API and extends
> > related data structures.  Patch 2 updates probe filter commit logic to
> > handle the size range.  Patch 3 Updates the filtering logic to support
> > the new type.  Patch 4 adds new DAMON sysfs files for the size range.
> > Patch 5 updates DAMON sysfs interface to fully support the new filter
> > type.  Patches 6-8 updates design, usage and ABI documents for the new
> > feature.
> 
> All queued up, thanks.  With a -fix for [7/8].

Thank you!  I found the -fix is in the mm.git as below:

'''
$ git show 81c69fbb4128
[...]
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -309,7 +309,7 @@ named ``0`` to ``N-1``.  Each directory represents each filter and works in a
 way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
 ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
 filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
-``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS
+``min`` and ``max`` file acts as files of the same names for :ref:`DAMOS
 filter <sysfs_filters>`.

 .. _sysfs_targets:
'''

But, I think it is slightly wrong.  The fix I requested is
's/files acts/files act/', but the committed fix is doing
's/files acts/file acts/'.  Could you please fix it when you get a chance?  Let
me know if there is anything that I can help, too.


Thanks,
SJ

[...]
