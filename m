Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774550;
	b=EvRE96bS+NGEDQVHiTXYoMJYLue4bnPQfI7TJu3NhySILSaMOk4ZRibUyXseNK6QpCm6
	 SfQFFjvnTYVNTKEY2ajnnEzxwM6gigUT0rjyXyhzxxu91b+eXbrcDOW2GatWp1JIVd5qN
	 L+8+k41d5AylwB8s+MZMltVLNrT//mUAJM7guehqAfvYzJf6yclWHr96a/7p1g9mirqg8
	 7eunEJUJPKT86d1d88urITXB6j1mw6K4YdB8X5xKpfuOrvDJogsmV8v3ovA5B+GhqUOjf
	 qdmJCy1Zi5OTqJwpyEv4KO+jr1LolgyO4hWyS4Se4cGlXlR5KtTP0zvwvzu3Smt6rUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	b=ZpddpT9Oc3E5kCou8PnlJyFEdvUv9PeV23+dgfiE84ldlaf6DSCDVNjrBm3oaNU4CZkS
	 8I4eS7gpr6mtLavvmLAZGUpHlKcxSRlzqBY65omm7foXE2qvg9B3hZZTbsNlLi/SBkDgT
	 Ym7ZeH2ZqTRYfiOFRIN+8/KdU5XQaQac18Ulbj0WQYjrEUY771SnhHWq7GcvVf5PgbMaL
	 0z8x9UlGuwrv2wlk3Vr11wSsR7c1GN5AnkdDoByWB6CIzif/dISMoYVfGOgTdYf5R9lOf
	 +jrw0g5Q8rot7m5Xfn0FrFGs6Lr7F1NMAaTeFoOGoZzZ9pP4aYzoGHwsfJ+nnhuoknw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsucGbY5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D29606B1C7;
	Sun, 15 Nov 2026 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsucGbY5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC311F000C7;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774550;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JsucGbY5PO0b0X2gdfNJLj7lr72dlBZusO/zeQGYSlouPpwvHXUVB9qA60l/jsLO6
	 V2t1XdUQGqKZd0robpScWriS+bKO7CIhthDVrxO5Ul4jJz5HTdRjRhdnLH/F2US+Mx
	 hSHIfg8lGPM1dNjKMk4KAPx9PWV+b2OfpUbAo98kP3oIu53fgKLcd7uMa2ZCXGEXjQ
	 JA8c4Q5wCnwAfbXHTRO9KMlpE/GsyKI+R3xKhs2G7idJCz900lwi71USWiOYh6Cm2V
	 TsTj+pDTstRodDHYUElmdoG+fbZKnYW+kritct46+02IJrDAiEZb9p2hVyf0tnSAvq
	 xQV4xdjFXTsVA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 23/27] mm/damon/sysfs: implement submit command for report producer
Date: Sun, 15 Nov 2026 12:28:41 -0800
Message-ID: <20261115202849.99134-24-sj@kernel.org>
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

Let users manually submit a report of a data attribute for a given
address range of memory.  Let producer_state receive "submit" input for
that.  For the input, generate the report based on user inputs that are
written to the appropriate sysfs files and submit to DAMON using the
core API, damon_submit_report().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5f9bb1955dfd5..0049aac6ab974 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3107,13 +3107,26 @@ static ssize_t producer_state_store(struct kobject *kobj,
 {
 	struct damon_sysfs_producer *producer = container_of(kobj,
 			struct damon_sysfs_producer, kobj);
+	struct damon_report report;
+	int err;
 
-	if (sysfs_streq(buf, "on"))
+	if (sysfs_streq(buf, "on")) {
 		producer->enabled = true;
-	else if (sysfs_streq(buf, "off"))
+	} else if (sysfs_streq(buf, "off")) {
 		producer->enabled = false;
-	else
+	} else if (sysfs_streq(buf, "submit")) {
+		if (!producer->enabled)
+			return -EINVAL;
+		if (producer->report_type != DAMON_REPORT_TYPE_USER_REPORT)
+			return -EINVAL;
+		report.type = DAMON_REPORT_TYPE_USER_REPORT;
+		report.addr_range = producer->addr_range;
+		err = damon_submit_report(&report);
+		if (err)
+			return err;
+	} else {
 		return -EINVAL;
+	}
 	return count;
 }
 
-- 
2.47.3
