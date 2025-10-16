Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F03346BF;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651262; cv=none; b=lAIC+4NqAsgY233IcWYlPQlQh+Y1jMwkAxHJps2FU4q3jIU1tfqX+L6U1nJE72++0KZjMCiRKfxPgY2FD4f9BDvaRmKZW2VlF0TL2I+rdVjc3ySVtNqXPUZlEXpEIvsSHasN0RV9qBK2jrTFmko74zL7PIDMVdw5+j1rH4v+udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651262; c=relaxed/simple;
	bh=RINJiyTikiCSrabu3YKbaCnLP0ZEjScHL1FfEOY67sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVjaxPEs1B9jXwqrDwAHzA87q4IdolB78G0eAHSWvqwOx4gEpZJA7buB+k2+Er2wp1UZYFJ1e/koCHWifWSC65FG6dZRcsYCq/1IeQl/M9T+jqP2QVJcDilgvTMDh5G6XC97d473NKkdykHoNqE3NV5fIx5odoiRGl6KJTgD8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5TPF4h1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5TPF4h1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E558FC4CEF1;
	Thu, 16 Oct 2025 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651262;
	bh=RINJiyTikiCSrabu3YKbaCnLP0ZEjScHL1FfEOY67sE=;
	h=From:To:Cc:Subject:Date:From;
	b=i5TPF4h1h+JX0pSFrm5nYS4UT9bNVvnMIafjwjgt2VpykD6J/qjRAzpm3l6gA44e1
	 8W1uHL0mZP8kN29CaJ2hG/SrG/HvqLyna66MAzK1j8763yRE157exXKJBDaRvtb1xD
	 meHmwHBkwhJUrsCHUhskq62xXQkphkpRs/5/1b5l1z6YB+p1MUsiPcgjpYXzdQDtaK
	 gtqo9Sb02SfKwCR3tzjQO3L0qVYwD8+uHeBVgEVvtQETYTihZXqGeDY0V4nUUawTNe
	 oEe2HozesoxP5FEnzoszPdrb9U3mW5JFmvkIV8aBddHYKGVBbmTM3zBJuGRw5a6tOt
	 mCgLTA/cpazBQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/5] mm/damon: support pin-point targets removal
Date: Thu, 16 Oct 2025 14:47:27 -0700
Message-ID: <20251016214736.84286-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON maintains the targets in a list, and allows committing only and
entire list of targets having new parameters.  Targets having same index
on the lists are treated as matching source and destination targets.  If
an existing target cannot find a matching one in the sources list, the
target is removed.  This means that there is no way to remove only a
specific monitoring target in the middle of the current targets list.

Such pin-point targets removal is really needed in some use cases,
though.  Monitoring accesses to virtual address spaces of processes that
spawned from a same ancestor is one example.  If a process of the group
is terminated, the user may want to remove the matching DAMON target as
soon as possible, to save in-kernel memory usage for the unnecessary
target data.  The user may also want to do that without turning DAMON
off or removing unnecessary targets, to keep the current monitoring
results for other active processes.

Extend DAMON kernel API and sysfs ABI to support the pin-point removal
in the following way.  For API, add a new damon_target field, namely
'obsolete'.  If the field on parameters commit source target is set, it
means the matching destination target is obsolete.  Than the parameters
commit logic removes the destination target from the existing targets
list.  For sysfs ABI, add a new file under target directory, namely
'obsolete_target'.  It is connected with the 'obsolete' field of the
commit source targets, so internally using the new API.

Bijan Tabatabai (bijan311@gmail.com) has originally reported this issue,
and participated in this solution design on a GitHub issue [1] for DAMON
user-space tool.

SeongJae Park (5):
  mm/damon/core: add damon_target->obsolete for pin-point removal
  mm/damon/sysfs: test commit input against realistic destination
  mm/damon/sysfs: implement obsolete_target file
  Docs/admin-guide/mm/damon/usage: document obsolete_target file
  Docs/ABI/damon: document obsolete_target sysfs file

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
 Documentation/admin-guide/mm/damon/usage.rst  | 13 +++--
 include/linux/damon.h                         |  6 +++
 mm/damon/core.c                               | 10 +++-
 mm/damon/sysfs.c                              | 51 ++++++++++++++++++-
 5 files changed, 82 insertions(+), 5 deletions(-)


base-commit: f82c3c7358c244b2ba14dadcae822c8d36cf2163
-- 
2.47.3
