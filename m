Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CD2500AE
	for <damon@lists.linux.dev>; Mon, 25 Nov 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732510636; cv=none; b=KXdBPq+qEQz5u68vYWtd6w7dErR+dAbal7ZdTF1vX+NVgZ9TkNUWEnxphr14KjFXf0DpSqp7qfRSKbtuQb0yGTdOhB1EJXdyat1DVJocr117l+IWm2D3Xhdb5ufdYFxGdZKANQVsFWYRlUQaNcXd9pvFfAzejLcJm3cR8lyaz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732510636; c=relaxed/simple;
	bh=1V5SplsaJaGZ5wKLwVEyi3Goj1C74LCwXLSRzJVa7Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJgNr+DGEbg/nDcAtMYMTYnan4mw38uM964/P+9pvpTOVbbCR497tyhlS2NtNtx5xvQkOPp8exPx/3Kmd2vmnp+9pllsBz15Y/63oLxbtgW0/Go3hAqHK6JehbgT3upMvnRT57gy/1INhG9ERercoBIOvu280njfZlxhSg6GlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-44-674403a439bd
From: Honggyu Kim <honggyu.kim@sk.com>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2] mm/damon/core: remove duplicate list_empty quota->goals check
Date: Mon, 25 Nov 2024 13:56:55 +0900
Message-ID: <20241125045655.1452-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LhesuzSHcJs0u6werXOhZP/v9mtTj89Q2T
	A5PHplWdbB4vNs9kDGCK4rJJSc3JLEst0rdL4MpY83Mpa0EbV8XvOQvYGhjncnQxcnJICJhI
	PHv8nRXG3v7zL5jNJqAmceXlJCYQW0RAUuLPnVZ2EJtZIEHi8d1FjCC2sECgxLX+xWD1LAKq
	EmufrWHpYuTg4BUwk9jfUgwxUlPi8fafYK28AoISJ2c+YYEYIy/RvHU2cxcjF1DNRVaJQ9Ne
	skM0SEocXHGDZQIj7ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERguy2r/RO9g
	/HQh+BCjAAejEg/vhGjndCHWxLLiytxDjBIczEoivHziQCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MzQfFp6/+dSxHMMqsV3BzCPPWxd47zGN8Xe6t
	nbA+LqxxmeWXuzcm6Mq0n9K1Fj545RbTvac/JhdHZupVPD7G9PLM+rqn7g9P/1EOfRT6/fmv
	h3+aP/PVGtsJvWhbcl9y9eWfhxetf6Gq1uu69WDZqeDdpg2ycQp+bUxX2cwy103+pDT/a0P9
	VCWW4oxEQy3mouJEAAxFwH4TAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsXCNUNLT3cJs0u6wYRGVYsn/3+zWnx+9prZ
	4vDck6wWh7++YXJg8di0qpPN48XmmYwe3257eCx+8YEpgCWKyyYlNSezLLVI3y6BK2PNz6Ws
	BW1cFb/nLGBrYJzL0cXIySEhYCKx/edfVhCbTUBN4srLSUwgtoiApMSfO63sIDazQILE47uL
	GEFsYYFAiWv9i8HqWQRUJdY+W8PSxcjBwStgJrG/pRhipKbE4+0/wVp5BQQlTs58wgIxRl6i
	eets5gmMXLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGA7Lav9M3MH45bL7
	IUYBDkYlHt4J0c7pQqyJZcWVuYcYJTiYlUR4+cSBQrwpiZVVqUX58UWlOanFhxilOViUxHm9
	wlMThATSE0tSs1NTC1KLYLJMHJxSDYxcd6t8Hu5UnG9neXpO4QOZqRvkprj0tnVc2W3S//38
	ntZKwUUfLNqZmzwuSJzJu1rUUrlXIVOVIaBwMrf0FQNJRekzb9td8xJMHD7nX3i7+6bmeu8/
	Uxjd5mS0H+iZK8/Krbf4+S/Du2nl6oGH8k8Jb3z16OVRUekZtwPvbJiTaPy0rPUzf6wSS3FG
	oqEWc1FxIgDZoFNQAwIAAA==
X-CFilter-Loop: Reflected

The damos_set_effective_quota checks quota contidions but there are some
duplicate checks for quota->goals inside.

This patch reduces one of if statement to simplify the esz calculation
logic by setting esz as ULONG_MAX by default.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 511c3f61ab44..ecaf78270035 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
-	unsigned long esz;
+	unsigned long esz = ULONG_MAX;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -1564,10 +1564,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 				quota->total_charged_ns;
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (!list_empty(&quota->goals))
-			esz = min(throughput * quota->ms, esz);
-		else
-			esz = throughput * quota->ms;
+		esz = min(throughput * quota->ms, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)

base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.34.1
