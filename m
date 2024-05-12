Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85B56B77;
	Sun, 12 May 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542626; cv=none; b=ayRICXZ+d0gPqYj0VnLTX+4IfLIRIhg2d+q+uAYPvVQATNfp/qArAr+9fc1NL52MRMAk2/5lWQvyDZkuSeWRemLc+QSLxN18r13rcLPjCd2qsTy8dt+fnBz4DRvYQYb6B/LikQykBBYpYvFOy69d3lc5NpxuSlQ+E9XhHMmFark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542626; c=relaxed/simple;
	bh=qXYTRSugt7rwl/3A7n+cY924/FHphURhvhYWI9AMXzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0voVWm4ciAjzFJCyEZj2amQXfZ0ORNwk8cFg/q6K+dh3646afWG6I1EnW/S8QEQglDAjzSNGTd8T4gjAazL1ZZeZBNWP2QUha9QZ4II8xSiU8ffVjIyHbVraVREUzEAocvhKW8cfQGt9ynyW8xbdsTJVk7ZGKo/9nYUTRFgUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+J22fH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+J22fH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081B8C32783;
	Sun, 12 May 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542625;
	bh=qXYTRSugt7rwl/3A7n+cY924/FHphURhvhYWI9AMXzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+J22fH/4YnyP8x5FrAEpo47lsNbj13oV2jS+1bItSJLZScow+ISz0erPzyq51tDX
	 omRw3NzuQiO1RBpqmHWxZkNdG/C3JpIBRCJRCbdigcjcQA99HuS1zHzIBjLEjyvLM/
	 kwq3wZLGlKZW9tGsCgDmoFB0XF9ZVchI0zsqHmkv96mGBGcdzYb+wpO4wWv7zIZLUT
	 e0crt2XhymhE1BsA7nONdVsfepGmV7Jk3FLLgaOEUqReDaQPf3eJt2SsfUKoYypJLN
	 FXf9Xgi9xcMVJdrj3qSs3ai2k7adxPQmN4NKNo1MKgwJi/TTmrrNUkoh3eJ0gORigB
	 +mWlKI7cGWgbg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC IDEA v2 6/6] drivers/virtio/virtio_balloon: integrate ACMA and ballooning
Date: Sun, 12 May 2024 12:36:57 -0700
Message-Id: <20240512193657.79298-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512193657.79298-1-sj@kernel.org>
References: <20240512193657.79298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the host effectively inflate the balloon in access/contiguity-aware
way when the guest kernel is compiled with specific kernel config.  When
the config is enabled and the host requests balloon size change,
virtio-balloon adjusts ACMA's max-mem parameter instead of allocating
guest pages and put it into the balloon.  As a result, the host can use
the requested amount of guest memory, so from the host's perspective,
the ballooning just works, but in transparent and
access/contiguity-aware way.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 drivers/virtio/virtio_balloon.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..a954d75789ae 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -472,6 +472,32 @@ static void virtballoon_changed(struct virtio_device *vdev)
 	struct virtio_balloon *vb = vdev->priv;
 	unsigned long flags;
 
+#ifdef CONFIG_ACMA_BALLOON
+	s64 target;
+	u32 num_pages;
+
+
+	/* Legacy balloon config space is LE, unlike all other devices. */
+	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
+			&num_pages);
+
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
+
+	/*
+	 * If the given new max mem size is larger than current acma's max mem
+	 * size, same to normal max mem adjustment.
+	 * If the given new max mem size is smaller than current acma's max mem
+	 * size, strong aggressiveness is applied while memory for meeting the
+	 * new max mem is met is stolen.
+	 */
+	acma_set_max_mem_aggressive(totalram_pages() - target);
+	return;
+#endif
+
 	spin_lock_irqsave(&vb->stop_update_lock, flags);
 	if (!vb->stop_update) {
 		start_update_balloon_size(vb);
-- 
2.39.2

