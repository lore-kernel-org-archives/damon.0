Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6F3DDDC2;
	Thu, 14 May 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767759; cv=none; b=gWmL7p+nscP5p13k21QRAGCZGG/C6VSeDJhe8HuGFAl/eQEDYQ+ZYZA5UkkuumJcRa/1REkYJ4/+8lImiBbZWLotoYvVuoIRh3Vq7rNnH+WF1QsNimJr8uyGfEBmJCTcTzyfgwfs7k+cDCQmYAOdNn8Fv+LA+NmSQNHW10FsWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767759; c=relaxed/simple;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdIXda4Mih4PQqtoqiEVimISFLLqsIbLoaaIEVBTsa4ygMb5Q6+fPjhyRTzOdKGuqxrue12Qkd+MWODA/V/LimQXnfjf56/QfDim9c90vZSC/YDaXWXCyNCzTcrgRVdctjLMPC6z2hW2u4Sfj3/FVWQc3YNmmB1rMSny4x5aGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOccwP0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOccwP0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE96C2BCB8;
	Thu, 14 May 2026 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767758;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOccwP0sYTpt4oDw5YHGzp8xb1bVZG7v/hzui2Ady2aOV3EyVeVh1S8ZhewNqVuS9
	 ZMKFpuUBFoTNf0TTcS1LdhXgwH0M0BBa5bGkuC1hVgvUbO/pggjnS3rmyy0vaYftBD
	 vhJngYgerbXcN96QCCLZcZIFcnLUyjMDdA46lRQlaav3TlxZ8Fe3FSD436Mo1ds+5O
	 Ji4L2pG0QX2fHvTd4ngCaftExuVhnZDxSSvl8HOeppZZVWVF8nAET3A0/dZvDkXjeu
	 AnYpxIJKznsYh6ondxnyL/W2oGtcxcPgJfK3uAmBrl+bE0rrLVnhGsW8/B+iTDa+bf
	 AQZRphXluoh9Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 01/28] mm/damon/core: introduce struct damon_probe
Date: Thu, 14 May 2026 07:08:34 -0700
Message-ID: <20260514140904.119781-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a data structure for data attribute probe.  It is just a
linked list header at this step.  It will be extended in a way that it
can determine if a given memory has a specific data attribute.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4d4f031bcb453..4794931fa2ea3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -730,6 +730,15 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * struct damon_probe - Data region attribute probe.
+ *
+ * @list:	Siblings list.
+ */
+struct damon_probe {
+	struct list_head list;
+};
+
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
-- 
2.47.3
