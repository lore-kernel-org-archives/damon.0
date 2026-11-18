Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968559;
	b=5mltnNdO+6Et/GVqosFi0w0iy3BZoFUvZzeGhF1+/begn7k/NBwLwVd2H0fWid6enY2E
	 gvhby5PUCZqX1cRgB8nf4xkEEDpW7xIBE+82RPU13TzRhwXHE9WayS5QMTHKHOQScv+Yk
	 F7Klzn78aM1cLbqQXvrvnVuWW/JNZtWe/rzr2BiMr0k9mBSY6/MKw2dAPGpKGrBel709M
	 KdL4Ht2euKNKr4Yo4VLoCuwJd4ePk6RTCmBsTW86d4liV7VCa1MdxZmpCsHSlsgg3dJoT
	 7kVNrcfo+R/Cew7RU0xFo/tuGw2oEWjmTOtbqwfAoZadU77uE8Nkz1EYjrN0k4sio6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	b=3juRA9jIKfBO7hcyedfuXDqPnSDxUqEHu/JpBcwy10jNic0HavW6jxgiFKTPIodQEyrt
	 tpbOmy0XApjp4FZsK/KIVI1RWlSSR9lwPj1ut64qcnx9uzWlC8b9KBEkwJm2/n7zYYF3k
	 rxnzoB55+Oocxyb+hduZUUGKh5zN+MJ8JtJf9sXlmZ66tnxSPlQzeJWC79sqZGKl6jjLV
	 srSDb84gngfDFAG5sClcaLk5xUR5OV4uswS5LiVCapU+ECXwVUcYgLiac0XPhgOF/fMxg
	 KTV3nKkipuCpmnksE4PCkS07gGQV7RHPSumpocQIHHKSl56ptUOMlTJz8K+pzAWekJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZudxf4I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161E60A6F6B;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZudxf4I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7671F00930;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968559;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZudxf4I+nlm4L5dLPI68T1QC1WdJc7DTvR1ULXK15rzL3e2ggKDs62o4guOnPcLG
	 CBcx82J0Jby9BZBw8RFcfDhwb4DEiCZScDCqVr48sPvGCOh7dGeK5uVz7sUU/9ugxK
	 uN23rNlYyRkLRU2N6OVv5UhNviO05EI3kxBjB82+J14mokBjtHLY1qqc7bhSOMk0lX
	 Z1rBySGatoo/XE40tQNxPuxfyK8/bglbgTRBYGHyQyZNFcud1+1eR6VDYprF11T8UR
	 VcXrEdQ+6zMMMGxXiVVh7SX0UTvEz/7hUygg4JGRpO7tp0DB9Yg2efF7ErDhquzRIw
	 +19TLT7Xlh6ag==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 21/27] mm/damon/sysfs: add user_report support for report type input
Date: Tue, 17 Nov 2026 18:22:16 -0800
Message-ID: <20261118022225.100659-22-sj@kernel.org>
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

Extend the mapping list for data attribute report types and user
keywords, for the USER_REPORT report type.  Use "user_report" as the
matching user keyword.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1c171af4590a8..b4d898ec0c9f7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1187,6 +1187,10 @@ struct damon_sysfs_report_type_name {
 
 static const struct damon_sysfs_report_type_name
 damon_sysfs_report_type_names[] = {
+	{
+		.type = DAMON_REPORT_TYPE_USER_REPORT,
+		.name = "user_report",
+	},
 };
 
 static ssize_t filter_report_type_show(struct kobject *kobj,
-- 
2.47.3
