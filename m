Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BE34846D;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116834; cv=none; b=A0rpAuSjCGevnyM1Sydp/iCftw48fjcnhhaiSLl3g13+DfEcRZ6UoyzvdBz4P7NkOr8gs5nx7yLOziGEUCfoes3565insjr2So2FU9jyTbC3pXIgc0HKj6jynxd9lesyZMvhmAP0pmEq65pnBbnZelGHDjgaI7z0ehcjDg+CRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116834; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssOHbYOacjq6C1VWwHyKYLNs9ELyXZ73pvDzGsixGvqJh3ttzmmXXmopn9Iu0Z87kKnaSjsWvwyZpEE6V2drQ6G9jzm2nbeTzzrH98BS13LT+ugb71oYCiHMb0cXMa7A9m+DIXsiny/brmc4jVhhqTWWYmc2w/2bEaf4kcwYvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aetrf1Uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aetrf1Uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43515C4AF0B;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116834;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aetrf1Uydmah2EizI4lkISB5+xJaT6Nm9dBOBkqWNOGduoikVochvnDQg1tvzv3RR
	 IgbpqLSuLqL3sqI0yMR0eMNfkgVlA0ui1l/WvZAKqUfFg7aSud0iU27hYRLcFMolfR
	 ++ckTTBOOO3w8gsrrgN/fgCLldaNCRne4/t3TT3Ed+rtp7zZ5emRChnES3pqpuEK2t
	 6bIMuLBO+bRNS1jVCkQla8GIAclEHMw65kD8E3j8Edw1qjd27HdCSPWyaOqYSAWssn
	 MC12zIo15NzxLcOG+KjCrBmaKVWXk8mDqoOWLrszeFSC6vIkxsuNfu48f8RtKbwrfE
	 JFntlnLdPqGhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Sat, 21 Mar 2026 11:13:35 -0700
Message-ID: <20260321181343.93971-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb105..7059f540940f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -84,6 +84,13 @@ Description:	Writing an integer to this file sets the 'address unit'
 		parameter of the given operations set of the context.  Reading
 		the file returns the last-written 'address unit' value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/pause
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a boolean keyword to this file sets the 'pause' request
+		parameter for the context.  Reading the file returns the
+		last-written 'pause' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
