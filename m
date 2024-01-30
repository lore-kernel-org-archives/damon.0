Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EF36B1B;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578560; cv=none; b=GNUeGW8ZGYQ468w90q2YdDVk0VHY01KbMwPz52D3ro2b+QoIF13dkPaqVUpnjkfQzrs0Yv4mljnJC5eavU/Z0VV7C0M4oUiNsTMDUBWHa8TbpEC6OuNRB6/KbUZhYTN3PimVpYyWsyILl0KuKIgr/gyXfKRsrl4WO2ESioP8MJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578560; c=relaxed/simple;
	bh=QwFDGVTfCJQhExDgwMfhXxVfZDEJjE7tnYoyx4MeyPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEy0B004EPCXvZmhUuLZintVuc9x2OFedxGkhHVYDzXsh031nBfxyM9nqGWvljEbbo7uBxX/+NhLLTbYQKqLAe5BzEWdyCcAp8rcjYQJghtEsJc9v+QmVtY0J7yQ3bTftHXB59maxOMi156fVmuEyT+x4yvN8IvFGkYslYDIHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn2kAJ64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn2kAJ64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95812C433F1;
	Tue, 30 Jan 2024 01:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578560;
	bh=QwFDGVTfCJQhExDgwMfhXxVfZDEJjE7tnYoyx4MeyPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jn2kAJ64jX3y9uusBNQba+8eCKSt8+re6HtxCuT5lrz8GaEdHb/UDdbWUpFsPzV/H
	 qz9NZmQUntd0hZVO21XYjgv5CulXkKXa1O3jOq+SOTjHYkQPGs5Z7gf2GqIKPD+yKl
	 iOD7bi+o09rntjgPn52bdOchOVvTPPkZReLtosLJjkRWtCucPbKLvg722vug2eMmzf
	 l2sU6+rEU+zLPTVEp/xH672L+9wm4bi9gJTkNDgun/kFVGHKk7BgFj66SwQAO2DrT1
	 Oy9yNc01U5/dhyvG4zc1Imxbsn34vWm0UxdP8/0c60W1c2B9PYIfyCs5JFE7YVsAHp
	 gv8DmsSs+ANKQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] Docs/admin-guide/mm/damon/usage: document 'DEPRECATED' file of DAMON debugfs interface
Date: Mon, 29 Jan 2024 17:35:44 -0800
Message-Id: <20240130013549.89538-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the newly added DAMON debugfs interface deprecation notice file
on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index f2feabb4bd35..5d3df18dfb9f 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -628,9 +628,16 @@ debugfs Interface (DEPRECATED!)
   move, please report your usecase to damon@lists.linux.dev and
   linux-mm@kvack.org.
 
-DAMON exports eight files, ``attrs``, ``target_ids``, ``init_regions``,
-``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` and
-``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports nine files, ``DEPRECATED``, ``attrs``, ``target_ids``,
+``init_regions``, ``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts``
+and ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
+
+
+``DEPRECATED`` is a read-only file for the DAMON debugfs interface deprecation
+notice.  Reading it returns the deprecation notice, as below::
+
+    # cat DEPRECATED
+    DAMON debugfs interface is deprecated, so users should move to DAMON_SYSFS. If you cannot, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.
 
 
 Attributes
-- 
2.39.2

