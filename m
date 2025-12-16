Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617003451CE;
	Tue, 16 Dec 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872122; cv=none; b=HoO3Afh3l9jsU/eakQfgIU+N37VVcd+8/gJg2HQGNCD4vvto/X+OuTHb32H8XoxX9IWf9Atf5d+PvAV2ruFbGeIXFiXUBzOuRiYr5OFJi3Gk5AOsltgz+qLKewC+tw12C2Zm0i2Y2cNLZxYMTrWgapmEwgx2gPbJftyR/EfwLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872122; c=relaxed/simple;
	bh=ihzFy5TOJPnYv7zeqZ3FA4BsW8yTIpVlYGwomLZgsUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MISVp4aWdm3ODAI2L2Y/orTHxxwueLuVLgutK43IzSesioStUXLkyy0M1ngNhbVyzVJgMBM0LaOAVEl444KS0QYyhRItN0Q+c8h8UdSYBRQ/jdCFd2C0a2MWC+TdoTc8xDagTJ7s16hS4iFZECLPKw6qtqOu9FCkY6MxrFwWbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxXE8PUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxXE8PUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679EBC113D0;
	Tue, 16 Dec 2025 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872121;
	bh=ihzFy5TOJPnYv7zeqZ3FA4BsW8yTIpVlYGwomLZgsUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxXE8PUMFi+wy0z7oFUzsOvqXnJSFUCjLVg2ARDbknet3abyC4cwZtsPddcglwbb0
	 z0ln6Vsi4imR36cGKInmAYGJXCQtWRSDDd/SB2xmk+2GYUSTCGqzzoqM7pHVdtn0kF
	 UfUDRCIvzgxdtiOMcOp8nfTPwBQJKLUcIKnRywtD/1R2X+bXr+8R8s2OAz7ucJTaBx
	 lCyBuC07SraNRQRidD7whHRB3VUByDviTFE38WbfUMkhMD4UcKTYMO2H6GoeGvWxVF
	 MmeRTIy+MCVH1LiK4vP6d8SVnRfKvboeoBa9gn3lltxZUH9/jnpWwaNNTEy9Yns90e
	 5fGU5jNhrrN7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/12] Docs/admin-guide/mm/damon/usage: update for max_nr_snapshots
Date: Tue, 16 Dec 2025 00:01:23 -0800
Message-ID: <20251216080128.42991-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMON sysfs interface
file, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d0944bd78964..7da4c002cb39 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
@@ -543,10 +543,11 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, ``qt_exceeds`` and ``nr_snapshots``), respectively.
-The files are not updated in real time, so you should ask DAMON sysfs interface
-to update the content of the files for the stats by writing a special keyword,
-``update_schemes_stats`` to the relevant ``kdamonds/<N>/state`` file.
+``sz_ops_filter_passed``, ``qt_exceeds``, ``nr_snapshots`` and
+``max_nr_snapshots``), respectively.  The files are not updated in real time,
+so you should ask DAMON sysfs interface to update the content of the files for
+the stats by writing a special keyword, ``update_schemes_stats`` to the
+relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_schemes_tried_regions:
 
-- 
2.47.3
