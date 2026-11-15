Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774546;
	b=WEQR0qt4GB+aH5Pb4orHfiJEbWYA7U3sRrdJIXJGNP8dgpiZj8y+FQgFeZ1zcj0NgdES
	 eh6X3zjiy6bV2P28+5298TbvKQGf606Eu15UMU5YQAPA5+jPqfQvdI/sMctlv3rHDZcTW
	 4jnhvv5fsUC9jZ+6OeNpd61qLhAm1Wc9OQFzUo8O9dwwZsuXq78+nO9r6xZHi1kN8wDiB
	 cXgzNEWYa/zh5ozRwIAV3WFbP8CI5hQ+QUe3Wn5Xj+vW38rd0kfxcHg5k+tG3iswYe7GU
	 RK82U+m7LRa1gkLYLEuACPukZB7tkvXF7aj6o5yAfyli06KmReENVfuhTyE39jbx/fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6gIxUQIo/TA1PIO0jTUdNpj13U+tqjhnz67nbkreB/0=;
	b=FLHhyMvV98dT7qNiE8lFdO2IsMM4xIxMLG8ns/1mxXZ8+9mz1C3zdRZ++j1C869zaXNc
	 qeuh7u8m74JAZuXYgxd/sztCVf5OEiQXqB33HKxVMwNAGochQROL8IuNp+AX1pPsjKlXN
	 1xDqYIIL5m7eNjEhCghdh5m5ckSTud/gYm7lADcpGZrNcu/Bm0baZDHXO0yFiSooMrbIq
	 Oxsm3CWxd2ICutIao79YJxiQtDkZG+dskGbaJjpJcjk7NET575IPbxvHnBF2J/JLSVGXi
	 +XROkQwsCwOd0q6tqPSNDAB00UHqskD3i0LrtVCaGZuiRHAIkwmzW4dbci8zNIe0J5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvQ6xmJJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2167606A329;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvQ6xmJJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945C1F000D2;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774546;
	bh=6gIxUQIo/TA1PIO0jTUdNpj13U+tqjhnz67nbkreB/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DvQ6xmJJtmDKQVvz7veeezW21iojwJCKmLcgN3cpqA3PNtLaYDr/JaTaePbfxC0/h
	 djgNWagXMtLjieepCkMuyrCQZqw5RohLAf4P34avIASU3q+9X5jDigFemK9bvOiVR5
	 02o4W5I0iHcQ8O1QFGoEQk2fLwENjCP7SMUZRA/EfS9KnY8Q9ocoa4t1OZUXr7Kusx
	 SJwF4nFiNy/iT8I6tp0A7XfOvgDYiSbnEvkl3OYedUKskLnCUrEijBF/fU9kSn9MJe
	 J+WUM2KSbnj+7o6rGntSo5S8qWoc66k/yg+tC0cG9I+TKHQlnirFWONRYYWsjijv+V
	 rtCvDrTjflb5w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Sun, 15 Nov 2026 12:28:30 -0800
Message-ID: <20261115202849.99134-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 mm/damon/core.c       | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ca0135c6f6700..cce7d344c585b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -804,6 +804,7 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  * @DAMON_FILTER_TYPE_ACTIVE:		LRU-active pages.
+ * @DAMON_FILTER_TYPE_REPORT_MADE:	Report is submitted.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
@@ -812,6 +813,7 @@ enum damon_filter_type {
 	DAMON_FILTER_TYPE_PGIDLE_SET,
 	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 	DAMON_FILTER_TYPE_ACTIVE,
+	DAMON_FILTER_TYPE_REPORT_MADE,
 };
 
 /**
@@ -834,6 +836,7 @@ struct damon_filter {
 			unsigned long range_min;
 			unsigned long range_max;
 		};
+		enum damon_report_type report_type;
 	};
 /* private: */
 	/* Siblings list. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 06b85d00e38d9..c02c7fbc1d864 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1834,6 +1834,9 @@ static int damon_commit_filter(struct damon_filter *dst,
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
+	case DAMON_FILTER_TYPE_REPORT_MADE:
+		dst->report_type = src->report_type;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
