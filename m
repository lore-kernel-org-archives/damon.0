Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534619;
	b=UuFo10P+m02EflvIZeKm73stu7pAVeKJTOfK3+SzhS8ZNFk8jBIoPyOqIdpmeeo7AN/q
	 80crnSlGOe4cxF/FCkncGgukuQXo0Y3QO2ukXVh6C76D1snMpDCa7rMNwj9KKMOtAjp0U
	 A8AHygoawULdn3uJ5wXTVAaoqMpEsLQtfXKdtD5XryQ8hTpmsNkDV1i+qrDS4e2lFbfLA
	 asjGHz0Jrl2PZcObXEvREmFL0MFl/r8tKHoEckCIRuFOyNX7c7INi2HVkqxpBSTcqdJ56
	 6wCrquTQXSt7MY52ho+E2eLt3xFumiQrzVdAIBSi/u/rwrDgXWY1FBlSocJ/SY6Uoug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bV7wk5atgqZx3K8k8thuwxM/GcO61onakPYDAERNzzc=;
	b=XAhZItBVo2dDyAaZIqgBftTXSHSx+pPwUcqUI9T/nP3IAmxuCEw4sVOVa/+lPWmZZTGF
	 i2sjy3sjvpEMExZjLtf890c2HBJji/dAcpnfqDbD5TKj8fw/Uan6OanvutPM4y4owxCAw
	 jzwMlwTMnchjactkp6WtgsfYffHQo83lTR2mn/O8x6b6G6BkQxRAARPQH/Yh7ImQxiGWI
	 HBgliPwDU4vOySUBUikSfoJCCoQ81FXcuuo6NXbezyrCo05GL79Ou5bbFnw7o30a9lfmY
	 MnNSNqkxywkOdxPm2iL5zJWnwhJDMrOGeqhsaOqVfPG+65Jw6TUxuCUckuVHbYHTPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUt25NHq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF3606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUt25NHq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447E1F000D1;
	Tue, 24 Nov 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534619;
	bh=bV7wk5atgqZx3K8k8thuwxM/GcO61onakPYDAERNzzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUt25NHqsWpO+D3tSnNCsehd7GAOO5VIeFCOff/Fw/iRUJn+MwrwrPF5GGmMJY42o
	 6MKq+8WUD1exqec9knCN1yC9l4U7r+cf1JhLm954XUOlxPAP6c34/KQY6ceCdeNQTW
	 sRmc02IDOCSXkGBitklVyQYg4heTnnIVzLbH7dmjXkSaF4QkTJF1+belh+tAwfqxpt
	 Hl4xnHZpXkNVGA4XdKF9T5ZV+RNyiTz+R7BkPewou4aZfzWG2U9Tkk7//WYHnxIbQK
	 v2lU7gAtkCQPmqcDiSeIVYrfk7oqXESZgdrSVuaJxqx8zAhrpGgeLfxf5vUscjVGrX
	 MQoV+60evlxxA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 20/27] mm/damon/api: introduce user_report report type
Date: Tue, 24 Nov 2026 07:36:26 -0800
Message-ID: <20261124153636.91854-21-sj@kernel.org>
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

Users could know some data attribute information and willing to provide
that to DAMON.  Introduce a new damon_report_type,
DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 38efa41b3d1ab..45c82f536da59 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -759,9 +759,11 @@ struct damon_intervals_goal {
 
 /**
  * enum damon_report_type - Type of &struct damon_report.
+ *
+ * @DAMON_REPORT_TYPE_USER_REPORT:	User-generated report.
  */
 enum damon_report_type {
-	NR_DAMON_REPORT_TYPES,
+	DAMON_REPORT_TYPE_USER_REPORT,
 };
 
 /**
-- 
2.47.3
