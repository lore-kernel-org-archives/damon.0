Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294825;
	b=vrvijQgeXvC2Ymm/Ljilry2nztb8FfpiePIqoMf2Pk/MvvBCzquTzg0ZfzmwTJFcN8Ze
	 UNNiHUCaGDFfN22zjGEX3BF6YOIw/OpaAijxBIlLCdiABotnu8NrduiBAFNP+PPK8J3d8
	 n0SCQ98zgoxJomwUSBzklpY3paxZydmgVKLWJCSv36hzLi37OmOEeXhLokxRbExwlgiam
	 TCFAUQwWoDU7MCD/x+ajURR1e91Hz1t6dT89z6KB1AY/jozwRw6RHzwp/oz1yOP0eVdZR
	 vdE9G1tx8v3nLOH2npelQBWSbD6pd3HgGNDzSdYN0aCyyhMdTtq6mJ428tAxoYwGjRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j9zNU7VFP9R08IpO6GDu4i26WmaNoJQ1rmpNbfyIt9I=;
	b=yY9rVvMNXtwzWgl93/FzHZMpfsghfq7h6HhS9mrMG/n2Dqsw6ddmJuPZJqN+RIHC0+UQ
	 JTzZOQoQfjf0KM+jnnk4qm4XVCLcM5Mpd0I8RibxSqNWDw/VWI8J5vVBvopNCX6/TENwe
	 dive7SY9vtAoccuCwKk5CjX4pnpV/rPEOWN887LLEdYnQjBOImbxUD25/iwZyz4gRijkL
	 VzbB6ubZw6qHJnhgkEeD949w3iai7C7G0AwlaL6T3+LuJsG40i2Yb4uz6Y7amIHnHrKUk
	 TLN+EAB8yoHqBdE9RshAnYSyQXkGVQ1V9c4/lmNp3GMN85miNtYSXGHuDbD0lNcpxSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dn4/oKL2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374F606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn4/oKL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A7B1F000C0;
	Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294825;
	bh=j9zNU7VFP9R08IpO6GDu4i26WmaNoJQ1rmpNbfyIt9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn4/oKL2StXi0ppkVyq6NMoGGStoQVOFsvq5r09vK+G1xmI0P3FbWkYbEhfDm1FeP
	 aTixH78iV/1vGXruWunbhtCTUX+7VzZnoSWNUoDHcy+0fpkqswWegR0egeFDdAFCUM
	 SDhMGuQeKfBFXlkNQ12gng3JeINwL2UCvjzeqUHvXt5kMf799CCLqCMf9S8Vc8uBUS
	 GvHlo+rVJNaLhIK7z12UhnIUruXIP+OfSAvw5SY31XVR1ewXALjCBStah7BBgT/mLU
	 mutYgJS89AdkFK4AGun2njPS8zIPIjg/yyyLbX6JihtUVDaW7dQxEa2fNd7RwgnMYK
	 TRlo07iMhQgpQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Sat, 21 Nov 2026 12:59:56 -0800
Message-ID: <20261121210013.130397-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
index 61ff3adcc69f4..54e0ed6561c05 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1833,6 +1833,9 @@ static int damon_commit_filter(struct damon_filter *dst,
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
+	case DAMON_FILTER_TYPE_REPORT_MADE:
+		dst->report_type = src->report_type;
+		break;
 	default:
 		break;
 	}
@@ -1876,6 +1879,9 @@ static int damon_commit_filters(struct damon_probe *dst,
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
