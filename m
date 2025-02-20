Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0D265638;
	Thu, 20 Feb 2025 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080819; cv=none; b=O3Y22tkC/eXOz6PuYJBb4Lpk37v/sd5CbNpzDwuG533t8REW2cJSU5X9Pom9J912W87vp0XkNKGgNf/AfWbEmrImxwsIjEdt0c8OcYzeNI4Bpf/y6dHr2w+1zhpQsqaX17moYhoAvaOolGgk0tjbVLyZHdsliI25yCSYSzxeKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080819; c=relaxed/simple;
	bh=nr8gMx8OR7643cAM6UGnwQ4mZJ3Mvv9MJo9TcURxfTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8J4AAgZAH5VyNd2X3BECGV5uzDAJdnPTHcKUaO03L7qoTqktmqKjrSeoJ9DW2MJIJ8yRh8kkys4XXTBQTHGZnyuCr+hDr4RxipJap5esFhERS/DHrviKQ5QTIn6UlY1bDlZwaAJxoMY5kGNe40di6kUAPzBHcqCPcQWH5jbx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJn9L2Jv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJn9L2Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E249C4CEE6;
	Thu, 20 Feb 2025 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080818;
	bh=nr8gMx8OR7643cAM6UGnwQ4mZJ3Mvv9MJo9TcURxfTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJn9L2JvryVbczIzy91hnqYdPtrPgnhjJM9l0ZjezGXCS0x+BVdPrOFnCMDIqxZNI
	 njxzMFP7Ev86cQcsfM9UHV84nOHL/5vNcAiLjU9jH/4wLrjR4SZpTE2Lo99umM8Q8S
	 7qPXgPyVIcP7LiS1PxxK0rgxWkS0pHLA5XPedcbd2K4Tn6gmp52Qh/S3a2Him8sM3o
	 1FuAeY0J9BIFCPXpiukeSKPiGVnRiNZ+qLOjr4zfbx3ft6lALEcAKVBA3HlmiJqYuZ
	 oz/2s3VMtu5BHvvk24CKo0mK0BxmJEJrZclq9/23BD2gmSEo4Xyz7iFFJ83wqBDXng
	 Dk/V3GoVpDkNA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] Docs/ABI/damon: document {core,ops}_filters directories
Date: Thu, 20 Feb 2025 11:46:45 -0800
Message-Id: <20250220194646.37726-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMOS filters sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ccd13ca668c8..9666074f06f3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -379,6 +379,22 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		applying the scheme's action to the memory that satisfies the
 		'type' and the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMON core layer-handled DAMOS filters.  Files
+		under this directory works same to those of
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+		directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/ops_filters
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMON operations set layer-handled DAMOS filters.
+		Files under this directory works same to those of
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+		directory.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
