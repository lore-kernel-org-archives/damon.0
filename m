Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272766;
	b=Ekc2K7X04ZfXnEZEGxjmXlHe7R0uRbGvrar5yrBfmN7DQJNXc+3Gxs0Ftrkw8RbAsuWk
	 V1HrArt869iSdlZAu8dkUcOWaTuBdSAtShylpIPrE8vIDb8DKOj2Yz9x1Dap2r4ws3M3S
	 N0RZbyCq/lHZdA9G+nyjoPOS0JZb+zJUn1/PTeeJ3Bcq4QPjVxaWW+VIyp62GA5zTKE/2
	 bxWZI5/KKOIfjjJXKvLOP8/RJErDOPkaq/08CEU4bXTI2x0NDS10PHatLqX5PWUtFZ1TS
	 mX517gM5l3NRrRLrUSbsQmD/hLHZrsfxGy1TfTbPVEQm+gi+seX8pYezJlLVf7oNtig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IaqtXb4shYGXU3OlBPma0gsoGJmW9Ovcsn7uO7R5/hM=;
	b=uZOx+EPLXl761+xgz/fq6zvO1ZC66lESAJ5qzSw+79Yt2ijEymp2+DjCwKk8cxOXgi5K
	 qIL737sOCeQsu53VM6ImtylbixV5EzbKvyGc9/LjdRyhCeM8b/HxK4xyl/tpKZypUEB7D
	 UAAqW1+GsSpQUfUo4vaqy5mGfraTL9K91bxt+fUtRo0Ovhl+x4CqSXyQtEPSMjklXtzjl
	 vVYnqcmaPn/mXGCz3Gf1upuAlaAW4qEnbb6Xtw6ItD9+RHaXx1jjrd7Eu+kebksSIbGiG
	 V89lTCmLEhYhGxcU3oLgWQFoFAGL6xn9HH2lX0BSGWbGSy/aSwu4G5q51fQDiaos+tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh2V6PGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC69606A330;
	Tue, 10 Nov 2026 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh2V6PGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8251F008A2;
	Tue, 10 Nov 2026 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272766;
	bh=IaqtXb4shYGXU3OlBPma0gsoGJmW9Ovcsn7uO7R5/hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dh2V6PGUWulUa8ThTycgn1OccsBy/dik+PQbHjhi/G9GKGlFgdI4i/xkKdNuIXbla
	 GiKlPNTpVbwlnOjEkUPJwmD64BQlEqaVe+NeS/tW1alC39C+jDDaOx4sVhPeduY0Dw
	 Z1V7E8chFZcQXFPa5xvOhWXipZ1vNhAaeJl9HW7RFMbJgOqoJlGN5Jkrn5Mih8M0bA
	 sF30AeBSuTERVAiHlGSvZ9gte5FjR/lNCMJCSCXWyiRKhARUACxME9iQXEWiqBIh2t
	 MruiGM6AiWR09vS9bG0iVQy/a44zAq1KZUOFJpYb/+NgjFDRaQu6MS5HX61Fc5/yBg
	 ukAKRenSjF4FQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Enze Li <lienze@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/core: use list_{next,prev}_entry() in damon_{next,prev}_region()
Date: Mon,  9 Nov 2026 17:05:56 -0800
Message-ID: <20261110010558.104905-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110010558.104905-1-sj@kernel.org>
References: <20261110010558.104905-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enze Li <lienze@kylinos.cn>

damon_next_region() and damon_prev_region() manually do container_of()
type casting to fetch the next and previous region from the linked
list.  Use the dedicated list.h helpers, list_next_entry() and
list_prev_entry(), as damon_first_region() and damon_last_region() do.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261103100714.70742-1-lienze@kylinos.cn
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 include/linux/damon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1302ffb6f0bcb..c32ef79c3acea 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -992,12 +992,12 @@ static inline unsigned long damon_rand(struct damon_ctx *ctx,
 
 static inline struct damon_region *damon_next_region(struct damon_region *r)
 {
-	return container_of(r->list.next, struct damon_region, list);
+	return list_next_entry(r, list);
 }
 
 static inline struct damon_region *damon_prev_region(struct damon_region *r)
 {
-	return container_of(r->list.prev, struct damon_region, list);
+	return list_prev_entry(r, list);
 }
 
 static inline struct damon_region *damon_last_region(struct damon_target *t)
-- 
2.47.3
