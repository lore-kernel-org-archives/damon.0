Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534613;
	b=J4tSoPRwI0XRX1Xu4QWJWpnifcmlVqgigEoVN1H+WY9qx3oR5nfG5YUZyaBDPngvFIZv
	 ogMi9Z90vNKhOAz6roD5/lnECbO3XxulphQNRE9WoDPtMrBozaxDOuq2lcc3OY1miNYrV
	 g2vhIRQRUyIAiftU+uDz8OXoxP/+scjT76n4xu4YkG8JICgBHp/KeghmqtvhP70p3F/i4
	 fDXit11YDEOMZJawWDym+rCGeFVuxf9kcTrLDAQoaxt9m+H2iSFLYhotCbG23djaVyekQ
	 nqtyuC1t9s/QoWY3P07scR9Ef4h7KXbfC6yoP3jKSLBVQASflxDlVdOy5cHq/42q/ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pnyPiUqFVF3Hx0zBZDBn3SkpvY286wpjABhuAXsQCTs=;
	b=tF65/M6oHCEFoNMJBCpuHLcb4H1oYF/vnUGLKoe9kKy2AAvUtdAUvOM0DL1YP9nKgPUO
	 x/BefyfHXGIlkeBLbOEI69S1SuvWXvg38WGyZaouEYQh4ei8DFAT4V4yltU43F5t4E2Gy
	 +Xjk5io7gtxRE29JEUkHcghJJhJbsbYlWs+zRiLhdgpMeFLgBGZbHjffTLObwVkej/iLP
	 eLmEMzhjiLkN5W4E8PXz0o/M2M31LWoaVVUx7pJ1pI9276DTccit48mDzZOXjEDJI0hMS
	 804xl73DGAirayKSo6XUcWGLw8trhxt44LNKe3SHTdJmAgildkn2w9Y868P3DzY6P0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSWuead4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA12606A323
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSWuead4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA691F000D3;
	Tue, 24 Nov 2026 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534613;
	bh=pnyPiUqFVF3Hx0zBZDBn3SkpvY286wpjABhuAXsQCTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GSWuead4LYsPNpUjZQu+tx5AWvfa1ioSl+/lV5GshlteDpCPwKbLynNYUIpHvuaOk
	 RlrkHnOHOK4+a6HsZnf+KLwE+XLuUqf7bx16CuMX6kOswtj3//w7FnPkg5837mIVVs
	 j9AvCmcX/MMjX+PSb71U7S2mgDT42PlnLFb6EQMWedsinx7i7S+0qnnrk7kLAM8/CS
	 yEj9DWaprzzreOTiKcON4gS8/SAI+89Rro7xZUL7FmR8HtWcO7cQxkDwcm/vcc6TOF
	 meoNWntRXqCau9x+3J7Y+TeLs77tXVjWmIjLUGWKZGllgN+TVxuVt7P+mhHCxQFora
	 vEzIshMGgPIiQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Tue, 24 Nov 2026 07:36:18 -0800
Message-ID: <20261124153636.91854-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Extend DAMON probe filter for the existence of data attribute reports
for the probing memory.  Define a new filter type, REPORT_MADE, for the
purpose.  Add a union argument for specifying the type of the reports
for the filter.  Update the new argument for the new type when new
filter parameters of the type are committed.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 30c0ab8d88c2c..9f48f17969d03 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -808,6 +808,7 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  * @DAMON_FILTER_TYPE_ACTIVE:		LRU-active pages.
+ * @DAMON_FILTER_TYPE_REPORT_MADE:	Report is submitted.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
@@ -816,6 +817,7 @@ enum damon_filter_type {
 	DAMON_FILTER_TYPE_PGIDLE_SET,
 	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 	DAMON_FILTER_TYPE_ACTIVE,
+	DAMON_FILTER_TYPE_REPORT_MADE,
 };
 
 /**
@@ -827,6 +829,8 @@ enum damon_filter_type {
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
  * @range_min:	Minimum value of range arguments.
  * @range_max:	Maximum value of range arguments.
+ * @report_type:	Type of the report, if @type is
+ *			DAMON_FILTER_TYPE_REPORT_MADE..
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -838,6 +842,7 @@ struct damon_filter {
 			unsigned long range_min;
 			unsigned long range_max;
 		};
+		enum damon_report_type report_type;
 	};
 /* private: */
 	/* Siblings list. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ae6ef43e5653f..d4a4aca4a831b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1837,6 +1837,9 @@ static int damon_commit_filter(struct damon_filter *dst,
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
+	case DAMON_FILTER_TYPE_REPORT_MADE:
+		dst->report_type = src->report_type;
+		break;
 	default:
 		break;
 	}
@@ -1880,6 +1883,9 @@ static int damon_commit_filters(struct damon_probe *dst,
 			new_filter->range_min = src_filter->range_min;
 			new_filter->range_max = src_filter->range_max;
 			break;
+		case DAMON_FILTER_TYPE_REPORT_MADE:
+			new_filter->report_type = src_filter->report_type;
+			break;
 		default:
 			break;
 		}
-- 
2.47.3
