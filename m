Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416E2C0F96;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672386; cv=none; b=tk0vd4cZL/gxv1pXif7c+5sfbKSaoLytHa9bmFuYbmDk8GeQPI0rX6+dGdAUdidBklH7k7AOltlsVxb4+yEPjSV9kUyVZobwU3cFfOpt7/27a8UeqDqmVfDMpk5f1aCtYOjRqln7i8UQQeupJx8zdFnJyakGkOITu1/7xVvJGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672386; c=relaxed/simple;
	bh=7VEEVzVbGPHB0sjJISOx5ncW5ljPkQ2sov44I7vDx9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdAZI6DXnaWQN7n3GTn+aqY47xPHfvCq2lJajccHcSKlSxLILBrEAsjawYkKg6/D1YbwkuVLlK9J8NzJP4vVMkeOwDPb94cXapgGTCLViiNQIENedeZMGEF4K4RM7l4CHv/RhnWNVNhuqbnsAKH6aaICNntuCmF+XUCqnfpoCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfM8M+SM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfM8M+SM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A4C2BC86;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672386;
	bh=7VEEVzVbGPHB0sjJISOx5ncW5ljPkQ2sov44I7vDx9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfM8M+SMAF0BMH7Y/czx8wjsNtMjpK6qxKcFNDq1uAuro2RDz5SmQDhDZgxVcckxW
	 oHwmY7YY24ge4I3TSAexHakUPVxF5vrAGp5nP8D4XeSv7VKXxnUgoDWTcUymeAffMx
	 0NckojFCHUHeb8fLIHrcNu6uq/iJ2IqsPmeo2Ekf+ivL3Urr9xf+aYwfjF8Aw0lY3t
	 lcmGsuS3MyaIInwmrHaNRVCAmyE81i3+iB9PmT0+XE8giU96meslckBAKAeATVN4Xd
	 h2BPRGje3+TCWCE2KqFOv4VBYRyLAlpGQDPE/IpVlT424mWtGJ8btmG2+kyINbbx4u
	 EpPLhEyy2tD5A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon: document damon_call_control->dealloc_on_cancel repeat behavior
Date: Sat, 17 Jan 2026 09:52:52 -0800
Message-ID: <20260117175256.82826-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call_control->dealloc_on_cancel works only when ->repeat is true.
But the behavior is not clearly documented.  DAMON API callers can
understand the behavior only after reading kdamond_call() code.
Document the behavior on the kernel-doc comment of damon_call_control.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bd4c76b126bd..bdca28e15e40 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -663,7 +663,7 @@ struct damon_operations {
  * @data:		Data that will be passed to @fn.
  * @repeat:		Repeat invocations.
  * @return_code:	Return code from @fn invocation.
- * @dealloc_on_cancel:	De-allocate when canceled.
+ * @dealloc_on_cancel:	If @repeat is true, de-allocate when canceled.
  *
  * Control damon_call(), which requests specific kdamond to invoke a given
  * function.  Refer to damon_call() for more details.
-- 
2.47.3
