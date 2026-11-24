Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534620;
	b=w7jTzRIbd1MTlBab7P7SI/hmkfM+woN/brbMaRelKAIA1JSgwivRP+4456CPH9ZJ/y7T
	 GRZ1lJp1aGaSXgEx7SEZr2TIYjwikHBHYUNnjQ70R8gK80TYl+QaWa6EZomSFL7Ops+2T
	 dYbwzdOCz21+c3bFhMYJrpuuqXOdn1GOcaUqOT+U9VJ1v4uZg4deVt+cxCNzpYxsTTNkq
	 uqsnYVy0MP3YH7TBaFSkb0dq758D1SewIbJtFQN9AzmFSYAIZDKxPHA2Hsv0e0juGUbNj
	 1vx6s/PRQgf9mLyRvyQTpqin3I3mgerIvpVWvaTahICKDfYW5j/CHf6GiLEhYnOdCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mwM0hoSsHT9C48OUdxiBZkgJJZRUAwe5QIB5lFSfI7o=;
	b=YJ73eZWCasOH2nuIAoohSv4a1HeucByq+DkHJYQ8chfcHVe61/aSy3+defoHBuoAL1OW
	 U1OhzywGMXzVgpJi+KG613AlO7PpyKhkRI/v+KLDA9btsiJKhcv3EWBcul4Er4JvbtfDS
	 LQyxShOU0yPAY4He5bQKte+7IdtQ/PAnToJ1wSoFk6csIFsMzRQF0C40gVSn0cLEmf+A3
	 q3Dz7A1p0APg1uUkz5tP7IYcIqf0312u5IRQa0dveATzyu2kpPA5nIPBQUxUhtLD8i72W
	 Y2soAX+NlBwa+9M55tNA+wSUvPieQdBlKgMccn/Uj9uzGXQ6/ay0dUV7BhujJ1uLl+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XifgZw4K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9186606A327
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XifgZw4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D601F000C6;
	Tue, 24 Nov 2026 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534620;
	bh=mwM0hoSsHT9C48OUdxiBZkgJJZRUAwe5QIB5lFSfI7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XifgZw4K2tnSB/k/ZxBPba0Bem9Q5u82Oyskw/SdLDwtQx2MC8e23t9Y+6MwxroGD
	 QJvV8SZ8Z0TK+l/OSdiMfvaGbEybya70MuTl6SKZsW/9Ef8AyThrP+6Pq6nRyLLZc+
	 mYAIa1c0CBkOZ1ahJJfaDotKdTNaaCxAw6IANvZ7F8sfQx7MddyPFejQzH1UJ1eTYV
	 90LLRkVwfNW93bzDg+5LGQY3tRPMjbfKYoB+DNnz1m8+XyXYFolaz+/I1jiB76csLr
	 STR75yJ3pxKanX9tWCrO9arns0bFBLQ3czeI1/r6DkLTFLaEuZydr6HsI/zD4520tH
	 H6wqgey1ONc3Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 21/27] mm/damon/sysfs: add user_report support for report type input
Date: Tue, 24 Nov 2026 07:36:27 -0800
Message-ID: <20261124153636.91854-22-sj@kernel.org>
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

Extend the mapping list for data attribute report types and user
keywords, for the USER_REPORT report type.  Use "user_report" as the
matching user keyword.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
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
