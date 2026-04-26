Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE824DCF9;
	Sun, 26 Apr 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236755; cv=none; b=kYkvJFxeH6WvVWHAXUTBYsRPY8QinG40e5ND9rDwVZi1EbfiO37/Bs9G6XMZKjRgvv1ubMa8CCJYO6kGJlClvZ1LukX0RyWtIgIMBoRz6L8iSNXGknWxTmkWYNYQdRZu16pQKAivymz/ZRGm6n9WEPBJhzCOtioF5w3j66zy3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236755; c=relaxed/simple;
	bh=1QadOMZa6i8GGLgIPAt5QhHokee8K5qEtWxld82M5Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5i69IpK0fW1xWxPQEuQiwRernbMe8mAEOETKN1q7LRp+BUIaOmXLuh+j8J/tLH7ZY1np6Aa5ioACxgi6N8me0U8LGXlgrR5OX0QBvBTfw6jC42yzBtNB1dCPVCpYC7580n/e0w0X9o155cQifvWidi7p6SFPV0F7v46VQPGfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3D5pfiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3D5pfiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C4FC2BCC6;
	Sun, 26 Apr 2026 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236755;
	bh=1QadOMZa6i8GGLgIPAt5QhHokee8K5qEtWxld82M5Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3D5pfiuhVeOi1wvnghj0VOW2j7fSBJtl6ggiQ/1yfV7+xkW46C3RLmgV6u25eDYQ
	 91CwAItN3QN/RDzy822cJJwXzvE5GOOKoT9gJ3d7BuJMZhTcja8z3GAQdjBXTnx15C
	 bDPq9to9W+sxbOHVJyeERJjT6D+6p/Uf+PTZJ7I9q+jyUKtgX2lTzAfSUHPRzuTqGL
	 UWhNpOO/hAPJ2mYL1Wskclhn9bmpCVVB5CM+w3T6PEsSvqu8IR/yq3cL1Bvn/jPw/C
	 4qnUJy8WC17BSO6uqXCxLFj32UFaRx5y0dNPJ6jcRkE5HOrY/JEd2WT9WmtS4xrweM
	 1SAj2DZPsBGxw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/19] mm/damon/core: introduce struct damon_probe
Date: Sun, 26 Apr 2026 13:52:02 -0700
Message-ID: <20260426205222.93895-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
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
index 7314fd9ff0d9b..da2f026eac725 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -732,6 +732,15 @@ struct damon_intervals_goal {
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
