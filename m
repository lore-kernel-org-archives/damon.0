Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3433374E;
	Fri, 17 Oct 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736437; cv=none; b=lll3kViSIErKssFDqldw7m0vcggq/WTnxZ644rKWrle/4/va5t5iE4sVNKwfFBcUPbAe63FBBQfGnV4ie653mBMTr8Vnrwjfz19GMSn8JpEyc9PT+64BZYqCQKnB+6cd6uQaOfiEWIsAhkeeSX52LyqKLqLvlEc9PtWFSOhY7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736437; c=relaxed/simple;
	bh=7XL7RxGNEj8c6993fvAFt0s4Fr/lZea2SH1v+aqXmgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hutyTboHwAcWoADKi0gfQtx9LRoQeANPDhWMO2tJsxQ+J8JXScdRffrcsAKjZlPSHBZldDcZIAsckPkIvD+VJuMabA+dO3X0s7Qiffm1qR+ufQyVjmIdBSioz/yG0yAAhQePOnUohSvjQI2PI0V6M0/6Ube2Fgxj00jqGkaG22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgsO98Fv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgsO98Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B79C4CEF9;
	Fri, 17 Oct 2025 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736436;
	bh=7XL7RxGNEj8c6993fvAFt0s4Fr/lZea2SH1v+aqXmgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgsO98FvaV+BXTnvfVps7yKqGihceycqqSVJVMPwFMoebj+z6AbjR6yy+miS1xeqb
	 I3CT+uF7OFfFcULkZQYdopgQmCG34P4QtAocVwNFA5plEujtnqanJX0RA62Zt7nas3
	 3YPi51UtDvyGWhxAgh5sFfsuQzqD0FWWbYa0ZQ2Rbv5q282UYaSRCZPdp/+fgqd6FA
	 F/V6llAPmDJwZ/zV0Nk5KrnuY1WAnpbAjQb2MBmqxduVO2QzSZeenpw6jVjNKeZ2o2
	 FggeUkALvzrU6lo6CIneHbaOgByciKZjGLPmvTV72LRApmmdgjOK6FNOMCuCPH1xx5
	 h9+aR6vEVOwRQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] Docs/ABI/damon: document DAMOS quota goal path file
Date: Fri, 17 Oct 2025 14:27:02 -0700
Message-ID: <20251017212706.183502-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs interface file for DAMOS quota goal's optional path
argument has been added.  Document it on the ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b6b71db36ca7..dce6c2cda4e8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -303,6 +303,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the nid
 		parameter of the goal.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/path
+Date:		Oct 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the path
+		parameter of the goal.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
