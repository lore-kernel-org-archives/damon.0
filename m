Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182F26FA6B;
	Wed, 26 Feb 2025 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551825; cv=none; b=UcXiQMSsMbsFGXokB5ydXrUAdxPzlUpGN0wMQpH8tMewQ5U60lFyplBbX/PqaAHFHplZfC7wOzQvIfFcA8JeGCFwhT2qkM/TQW8RGLLjPnf7BY9u7jqhz8En9F988F+Go73DHRfNPdiKn8BM9dWZXVlhs0XsIbFomnLW8ABz19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551825; c=relaxed/simple;
	bh=7J5ghi8H2WMjQQb1EvkfdSEY5M+51vnK26msM4ePujs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiNT1oH/T4usFTagJsVKycHR/IOTpyw6WTlMnuxBRNmR1CZYFtOx4vIkCOBxc5jTCbOlP1eQo41lS0arZ/rtU3MlxJwFQVRfoZGZZ9cnw1xLe0h4ocy5dVM8y1w/Qo+sRt3B5rIWWGKwFgwpDVgarPRgT+aUYZP3+ecoewgTgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK4TDoVk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK4TDoVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD050C4CEEF;
	Wed, 26 Feb 2025 06:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551825;
	bh=7J5ghi8H2WMjQQb1EvkfdSEY5M+51vnK26msM4ePujs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MK4TDoVkFXgj08qkJ+EcQXH+mw3NjLfnViyo0n3e55anSepeTY5jXsyN7Yt5mkqxV
	 Lulnr/k/dX1l+iDioETho9Vd/iKLfxVPHn2tQEzbbbwJrdKMR6gNJs8nBLXVw8xSUz
	 YPbvl7K0LN+3bPsbgZjXPdB5R0g+QcqPj5cxEPJteD/+HCZDOha6Wm+W5Ob7gXHQvZ
	 LoZbADvdbvVZ0Rx1FwPCGaQsb0JC3ykTliyJA3LCvbxDHkF6R3/ctpcvkmzPLTQ/tK
	 WHARxzqIRfK2FN06WamKGPZYWdgzffwMQ0MFOfdZDm6KjryghaYUT4LtsfGA1Y2aGO
	 OI7eQC+5MP2rw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/13] mm/damon: remove damon_callback->private
Date: Tue, 25 Feb 2025 22:36:47 -0800
Message-Id: <20250226063651.513178-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field was added to let users keep their personal data to use inside
of the callbacks.  However, no one is actively using that now.  Remove
it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 636dcdc49b22..2b783c91cbb5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -604,12 +604,10 @@ struct damon_operations {
  * @after_aggregation:	Called after each aggregation.
  * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
- * @private:		User private data.
  *
  * The monitoring thread (&damon_ctx.kdamond) calls @before_start and
  * @before_terminate just before starting and finishing the monitoring,
- * respectively.  Therefore, those are good places for installing and cleaning
- * @private.
+ * respectively.
  *
  * The monitoring thread calls @after_wmarks_check after each DAMON-based
  * operation schemes' watermarks check.  If users need to make changes to the
@@ -625,8 +623,6 @@ struct damon_operations {
  * If any callback returns non-zero, monitoring stops.
  */
 struct damon_callback {
-	void *private;
-
 	int (*before_start)(struct damon_ctx *context);
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
-- 
2.39.5
