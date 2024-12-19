Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B01AAA0A;
	Thu, 19 Dec 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581037; cv=none; b=gglK9kq3eGNpqdrmruhxp8tTu03SR5k5CFAQ8KE5+TYtp/HJX3tOSOrB/ZKRjDlmgpYwtE0UwPgDEbZMOeFKo+ld1qZxIXV25Y2jAA5dwTKlRTxs1bOBMnpwBP7xDBTqqaSfnJlPYJ8jgtuiRpINKJjOeVqJpPrRUvAzbSHMTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581037; c=relaxed/simple;
	bh=SFVsdgaR2hHAdxlVsqMnuhaABmN7P75BtajXxh6t/oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOg6sSIC3aYVgnnt1MXvqBMMjIHvDzfFVRBh2uAv9qEMXUVJDH48YmUBWrZ/zWSiF0Cmqoxv3OucAo7qiaayoZDhhXXJhGZyQBWK5j0bAsJfehop7BiWmFogm3qeunoIvQG/XOR7exfuUOUs/TCtn5iMGDuDYHSsZN3miZfTmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMRVKSH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMRVKSH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A404C4CED6;
	Thu, 19 Dec 2024 04:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581037;
	bh=SFVsdgaR2hHAdxlVsqMnuhaABmN7P75BtajXxh6t/oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMRVKSH40MOgCu29r5fBQZ0M8XOPYWcUwyzFJ7+iG2omCmV8DLvli9q84rxzlC/Jz
	 fXJMUhBZ2uTeoeGb3DOG7JXXCiVX/0hC5GWT0OkekJ2d63I09IT6W4nkUCfUpa3a6u
	 gzrmS0l7JxokrKW/+YyUNupEl1ypEqC+FAvC48o/AID0SQk6hm7CyMzBpgIaZ9IRrh
	 xyVHol5hXqrio9JK6iT6rYVftCGCoTZJInzGgx5g8X0lIA8kSftPqPrc/UawfiL+S1
	 gaI3oGQitPLAq+gLyK5tJqSQphArUn5q9LvP+/7cpwyq1kZHVh2Np0WYBYGkmtt0Bs
	 +4ALmwVqgmLag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/18] Docs/mm/damon/design: document per-region sz_filter_passed stat
Date: Wed, 18 Dec 2024 20:03:25 -0800
Message-Id: <20241219040327.61902-17-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update 'Regions Walking' sectioin of design document for the newly added
per-region operations set handling DAMOS filters-passed bytes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0620675a1e8d..ed3072dc8686 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -586,7 +586,8 @@ Regions Walking
 
 DAMOS feature allowing users access each region that a DAMOS action has just
 applied.  Using this feature, DAMON :ref:`API <damon_design_api>` allows users
-access full properties of the regions including the access monitoring results.
+access full properties of the regions including the access monitoring results
+and amount of the region's internal memory that passed the DAMOS filters.
 :ref:`DAMON sysfs interface <sysfs_interface>` also allows users read the data
 via special :ref:`files <sysfs_schemes_tried_regions>`.
 
-- 
2.39.5

