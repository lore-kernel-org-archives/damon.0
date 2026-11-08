Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165384;
	b=e+xSqDFJNseurU6iSjMPmfRrWiM+PY6MkoPH6oNRRQ5WTa9YhixlC3/CGlpqymb6bFWg
	 tO/hE/3Mi8DI0ZZi2StHSfztxqzprY6ZcUDMAU2ZjCeUMh6Kuh2uNP1aXhM1lORMhsX7h
	 lWxzuC+CCJyIvGZtueu8e6Q6ZT1VmqQsdRkkheeeOnpaOUwbOWO2p2ufOrqnS0kLFbrGq
	 8X03hIf1tWk4gCL+BHAU11vemxgzwiQxN3uitHxLEfkh7zj+X3i1tiWP7SubbDWsw6cwV
	 BwOlXA+SV7+5yFeeLtg8LVBzR5UmZKtJTzDQPSLFVtwk0sK54vE+bo7pwHO1pwTE+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HEvMyrDAXRSzNt1aAK2qvgfoj7RJAzXbHjO64hkCzVk=;
	b=w13m5NUTSzzsUOemAf7q8dM99YXUlqq8ePi7zv8QKcSx2ZH++iTvmU8vHpJnRqaJo4nY
	 7hppugmAR9bebfkTEoORq6xNQdAkmeneSRL3fvyrc507gK5JDooa8gVhvm17FadC0xD3+
	 VT7utXseQlkQPFWBgoewUC8l9i4SLl+ZdBKDTtVfRaJ3u8xD7nzg3Czf78Ql9yhAzdCWE
	 o92vbR96RYZLv+t8PMyBbZ4SwEHA3srVkxEruJ43kPNo53d/8amUxZQ0i6vZMQBwB+mxk
	 M1wfihPnoypjFU+wNYnd0qi2rh59pDxnR6bRJ4UqQFKoURnxamWx/p/VW7R5uWKXfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLKdElFn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67721606A333;
	Sun,  8 Nov 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLKdElFn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003E71F008A4;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165384;
	bh=HEvMyrDAXRSzNt1aAK2qvgfoj7RJAzXbHjO64hkCzVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLKdElFnNCfmUnBn9aOOenl1weRXD/H6YbcpW9wA9WR+soFa28mHyOVI9iqQpBogp
	 xayixgY7vJsymheXwiYrddX1JfqByf33rAfo/K2VN9+gSpioDzJ/LQbq586rvg/zIP
	 8JtZ9o7HUjSKLW9/uQNEMWY8EZIwkypdIowsxiqNfq10XizgeISNYUbn0oAQDs12tE
	 Ff7bM/EnJOHTKVjdHzTg77Hm0IyF6tYoxGMkZVIFCtfHFTLPfcOSl481JN2vIAgaBQ
	 oYA2lb/PYqYcdGbUUfMDBryzhykLOfEEwsZbbSwtah9AHvfA93JEtBbXyfoAhnZWgq
	 xZAMGIckEoepg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] mm/damon/sysfs: support LRU-activeness based DAMON filter setup
Date: Sun,  8 Nov 2026 11:16:13 -0800
Message-ID: <20261108191615.113362-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108191615.113362-1-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
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

Support DAMON sysfs interface based setup of DAMON_FILTER_TYPE_ACTIVE
type DAMON filters.  For that, wire the type with a new user keyword,
"active".  Users can set up the new type of filter using the existing
DAMON filter setup interface with the new keyword.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 70a4b64fb8ea9..779c98205a94b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1011,6 +1011,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 		.name = "hugepage_size",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_ACTIVE,
+		.name = "active",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
