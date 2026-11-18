Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968556;
	b=GR7R9IDqle5oaF3MBF64U+Y9JSyBj+sTFjQ8l1mfMkB+B5cZD8g+ugFt3ifDf56c6ZQ+
	 wpIuV17H6hItQN1bldhAsilgCNwMVrFP3Zku82h6FYgV3AonSyitN+Js1CmYQ4azGBV3k
	 gk8B4GOo0BhppPhrtf/aB4cDpRdr6/HrvPZFVb6Xp3qHKlS+Lz1F9ytUehvCieftoEDGP
	 fYJNVRoYXnSF2b0DvwJCraVsRXvi/07qC/yR6kyRNQjjbak5aHvSehThFghAepqjSeEoc
	 4xKulvXBr4/83K0tJXSjrIdmCEP+L6fPX6cMd6MSGT9oYErMVYV4lsMJ6o75gAYnteA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O0jEw0vpg92YutRbGpQJgZQWm6ta9X/6Vea9IHOffLo=;
	b=qwWjdwD7t1/TLaLyWb8wa2ZxkM/KmlS0E8UpSFqn6YsrKlt7vWCSJbtIe1aaU2RoaWj7
	 KBnC5Qo0NLQ+9dKGIDydN7irUBa1S3XqtFFsKhRwsgqX8RSq2EvAaFoxyZOQk88nsBDYJ
	 3xpLO1XDXVkQgEmESUm3bosD9/RyTP2+ijECd7ZxlQgCBtHl0H7cmGIuwFdA8HCFC2KUX
	 rplGh5SE7DhH4QsV213mdIAaJkpHC0tx3xwGiGjKdg8tCXv0/TzI7MgXRGroJLMTNHjAF
	 SYhqTta9wntfjoAk6gRjqmy8mIZPDFZBCnY+UsHA1BlNbMWc2l7pANBzCnqhH155ZGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfWc1Vwj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B84606A88B;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfWc1Vwj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E29D1F0092F;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968556;
	bh=O0jEw0vpg92YutRbGpQJgZQWm6ta9X/6Vea9IHOffLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfWc1Vwjm47bFXELB7zGY2VKkdsDEEJFd6PTeLUmNvuhafE7MQTvYh6JHXRea+0LX
	 +2s2hlsNbzV6Q/0fDza2f+ujHwk9BfSva1OTlP7gJrpBj2DqA64QKZiQ072Nn3SEGi
	 ZEE0Q1rRce3KjdftZCTyZE3fnLY0dB6/GSWK/T8hPD0r90Flbfskb36ZbHXrCGg5gL
	 v4E+Bbb0/L/sW1l+cDfnBMh3Uyc2v34jEw2lKE2QC+TbH+cUWPMNCMkPVPmWQ7ypfR
	 dxki89OweR3zDk1QxZtBWaHC0AX7NjYSuobbm3NkQIDphaVwvrhDdKpdLzqz4igt4D
	 dcMZbR0b15Vaw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Tue, 17 Nov 2026 18:22:07 -0800
Message-ID: <20261118022225.100659-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 35ad002d1536c..09f0dfbde8966 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -802,6 +802,7 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  * @DAMON_FILTER_TYPE_ACTIVE:		LRU-active pages.
+ * @DAMON_FILTER_TYPE_REPORT_MADE:	Report is submitted.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
@@ -810,6 +811,7 @@ enum damon_filter_type {
 	DAMON_FILTER_TYPE_PGIDLE_SET,
 	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 	DAMON_FILTER_TYPE_ACTIVE,
+	DAMON_FILTER_TYPE_REPORT_MADE,
 };
 
 /**
@@ -821,6 +823,8 @@ enum damon_filter_type {
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
  * @range_min:	Minimum value of range arguments.
  * @range_max:	Maximum value of range arguments.
+ * @report_type:	Type of the report, if @type is
+ *			DAMON_FILTER_TYPE_REPORT_MADE..
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -832,6 +836,7 @@ struct damon_filter {
 			unsigned long range_min;
 			unsigned long range_max;
 		};
+		enum damon_report_type report_type;
 	};
 /* private: */
 	/* Siblings list. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9d492a9aaf550..24729be5ec4e6 100644
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
@@ -1877,6 +1880,9 @@ static int damon_commit_filters(struct damon_probe *dst,
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
