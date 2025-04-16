Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082822DFB9;
	Wed, 16 Apr 2025 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777567; cv=none; b=E6pgZ8OWpVOo3j3Rd3FsgIwlbEy+7AkVkwvuTkIPXDdKMFmX271tit7bYPCgorxh0WYCn6daLYWL26Yfa72TsLSUadrBOYADMI5+c5oYAPKOArfFn2fFRXbYRIdBrFkYbRdwRCVt66/woI58Isj8NXACV77FObgEVPNWpjxA7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777567; c=relaxed/simple;
	bh=/j1OS/uEyNfmo61ogba2AmbAcqgkLIe4DTdICsLDGto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8owfhgTqtAasS70s3XLxfp28rEku+N4spGTwSik+nA+xYrvDKdqETmil6xMxa8GwyPbKvUWAoU1ld8FY5Ua8IAOeJfI/WK3ILIAIar0d0/h7cR71OkI7BJ1kJZ+wTYYWF8nTVO5ScuzIosJvLV+VlPLkGexnUghxz8YD2hS97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeZLjGNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeZLjGNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CBC4CEEC;
	Wed, 16 Apr 2025 04:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777567;
	bh=/j1OS/uEyNfmo61ogba2AmbAcqgkLIe4DTdICsLDGto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeZLjGNsZfaOR/wNb2zAJnAqECgTLd2+KnQHaoi8xm0hsVdUPDBz9KXeof/8T4t39
	 QgBFbvKAzuR17LCpb9dl/GEhIYZ98yXKdAbbYnUNMWDavvk/S12W2L5elH4FQKeYgB
	 9kXfLVLVvK9vmZuACGdRVR6u7afZxS6LLfatM1QtIam65SxWxQ2nRzo/lf46a/fWkD
	 tm5bO23Q8EG3qSfwE3BCfJ4/QTEldcyPXUPhiBeBJTv9hINwya8nXoeyN3tETOPskn
	 hJA7vw23dpe4AtheuhepzJkmC+iO2RqF4RU0NDflb49ybjmkaU5Q39l3bFcLDnhfYI
	 le04l8PTI58YQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/10] Docs/ABI/damon: document addr_unit file
Date: Tue, 15 Apr 2025 21:25:51 -0700
Message-Id: <20250416042551.158131-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document addr_unit DAMON sysfs file on DAMON ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 293197f180ad..40b7735f57d5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -70,6 +70,13 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		Note that only the operations sets that listed in
 		'avail_operations' file are valid inputs.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/addr_unit
+Date:		Apr 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing an integer to this file sets the 'address unit'
+		parameter of the given operations set of the context.  Reading
+		the file returns the last-written 'address unit' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
