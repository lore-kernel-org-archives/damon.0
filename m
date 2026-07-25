Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD223A785A;
	Sat, 25 Jul 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013362; cv=none; b=d4hvfZGH+cHD9cfl/1tLUdZAxsSZ4fqPpNj3IMww19aEIQ/ckDDAshJu1j8r6Nl++bnIxeFvWwlSn5+fdvZ7ldbRtjoZ4d0TVRhe5vTzet8zn650MiqNz/e+KZXeBtv3dnTRv8Rgfzhzt766JVWLVI0KoK+Nodxmp/3NgUfrk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013362; c=relaxed/simple;
	bh=LfUBLzj2uLeLsXoH9maLrSltT7mLeQwTqfSCV79lxF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL69zoM1D1Mvq9vKKQyY6C3i0l8zO6iSB4v2s/bf8vo0SXwiXY1LuzAJzVLe2xiA2m6f5jyLT+IdlMCIBgRm7s6vMcLXeWSQuqaq57AvH3dh4fuwwF+FjuMnQM/jIMdWCLh2XRF0Ih5L9Ns6NGsZF+x7m5tzLMLB3yQJOS8tpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToaRLvWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToaRLvWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246251F00ACF;
	Sat, 25 Jul 2026 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013360;
	bh=lGAfYBcye8NcUlTLvbjwlCQLfnRNUH/n12fXnvN8FwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ToaRLvWYsQRSPYrpcwZ1LMMJy0m62bo1iqX662YIPkyoJQyf8Ie9XvZ2OtRHDELRl
	 uQMe8UUM5/gK52s1WeFdkP9rpkBW6Kcnd55PtmiZowD5/M3e19CZtzXA15VBRpfsQb
	 gVuLqf/Xyb8RQfyfs2t96Bx13KpqWdYR+eBHsJqBz65OLYg6dnJ/UzxlT13HdXQqGp
	 uWjyZPe6fLns/xzwJ+a/aLvZi9+l9iPFyxF6Hyd77mHHBAezilwp4sbD7wplbdcUWy
	 JDFMWWVZjonJBemuWn6A6CNSFqUi/2KU0OrRu4fY/LEExoCKLwJRKsITqkLrEAY1+m
	 XPMVFrcA3pO+A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Sat, 25 Jul 2026 14:02:20 -0700
Message-ID: <20260725210225.129944-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMON probe preps sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index da5f9afd08aef..1f5a39e1fc38d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,6 +74,9 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/weight
+    │ │ │ │ │ │ │ │ preps/nr_preps
+    │ │ │ │ │ │ │ │ │ 0/prep_action
+    │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ │ ...
@@ -283,9 +286,18 @@ In the beginning, this directory has only one file, ``nr_probes``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each monitoring probe.
 
-In each probe directory, one directory, ``filters`` exists.  The directory
-contains files for installing filters for the probe, that is used to determine
-the data attribute for the probe.
+In each probe directory, two directories, ``preps`` and ``filters`` exists.
+The directories contains files for installing probing preparation actions and
+filters for the probe, that is used to determine the data attribute for the
+probe.
+
+In the beginning, ``preps`` directory has only one file, ``nr_preps``.
+Writiing a number (``N``) to the file creates the number of child directories
+names ``0`` to ``N-1``.  Each directory represents each preparation action.
+Each directory has one file, ``prep_action``.  The preparation action can be
+selected by writing the name of the action to the ``prep_action`` file.  Refer
+to the :ref:`design doc <damon_design_data_attrs_monitoring>` for the list of
+supported actions.
 
 Each probe directory also contains ``weight`` file.  Reading from and writing
 to the file gets and sets the :ref:`attributes-only monitoring
-- 
2.47.3
