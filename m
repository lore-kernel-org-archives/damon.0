Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619083B813F;
	Tue, 12 May 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596618; cv=none; b=ejCM2XYKI+SLJIadT26CWwrD0MzWdY0hKC3hipQ1W1AfIs87DGW0cUHnWpQ7+n6PqoGt2ZldAY5udixRlbPNhArNnvLAAD4kbKmkFH6nj6kGRRDY8ZKuD8CWBdicoLmLaslkCZ4kiLFiuHtLFWngnBol6NMj7gZUTteQzAfA7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596618; c=relaxed/simple;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmd+nja6rRYcP+8K4ad2f/3ZKSItIhtC++jnWaoUHx6csRmpKIaoIjRKXtsNZ5MiQUDdnEWjXjX9msybvZDvjCxcUMe/aekRAOlJRNkF3kodF1wFpcfA6TQ+zKqzuuAeTaWooITnZYreEo0L50l43baLkaPZgRlGka3F2D1X7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8AlupVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8AlupVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276F6C2BCB0;
	Tue, 12 May 2026 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596618;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8AlupVLS1/yOZDBq/YBHs6Etf1hzyDcoDgyGOywrrbHpKek6miAl160dXWIV/axo
	 USjQNX8qlTa2CtPD2MmEvaJJSHpO7wpwqFO3UIz8w+ybbqatFdNSVXKB2jzPiqWiK7
	 nn9HuL/R6aPJGnvjDveabwfs5EY8V4CxUjtVAEyeX51gX1fUxmoCZrGeLo87uyOg+y
	 PJnvvjvOAjqe6Lis/onqkS4hWs5G8KE81O9FhaAwFol+Ue/X6HibYtLI4b9Pmn33UD
	 E0SCs8jb0riZTbQGQOzECIKM8s4mxgIUfIWeehWjdXBqnK5BITutYf15csztKw1hP9
	 jF0Zgv4lQMpKg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/28] mm/damon/core: introduce struct damon_probe
Date: Tue, 12 May 2026 07:36:16 -0700
Message-ID: <20260512143645.113201-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
