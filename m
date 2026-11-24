Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534622;
	b=bL1d8iLDC5pXsah4IM+glh3tf2DAw9wFY1hE2jZyYRr5J5lL6n53YBhOUvrqI/k9Av20
	 UTz18F9VFAvPHrG+jP3jV/E7GknlCdaS5dJEgKcQbNSguIJdVUVTOsaroFHIEMk55on8h
	 8FlL20Ru33VYDP0qY9EBXAkaawymuoLiwpKNNruqW6gDJtmyEOLbNfNh8BvmmNNFY3grg
	 iW+RKvUVXi/N65HhPjbixdlNp7VNDjXbx1024YhOGKfMb9VkAJwrGDAjFl8pFW8KxHHWx
	 iNyW+0qWI19SK2F2zEm33498f1aJVNtEcLHJ7rgLxFdH2DGhRO9tTYd3IyRX5niZZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xP2PZrRzRQskbp3UIKwWTuWy1Ghia0qerPJ0DlNpJYA=;
	b=itq1jqdsiXeKr3KlstAypQ0GV1yHxqRxsDehynnN1SsKaKfZH+KelYdvBpG4Gdn3vO9K
	 Dy0XIQlMKEPTjgGILfRXaZosDCVUQyLVB2F0ktdtvxRn85dvDH6zqEOQF8dEJGkNdhqGD
	 jxqMzuphkzDqeOfWyVRIa/D8cLRw5olwlKDJb1v2aREtSqKewwaT1cuPhMS0e0TtEJIat
	 Qj4j3XyK8yGKsh+URzyAWEGy8oy2z1stWDx+iRzEou8RJvnc/4ljcUR05CQenqq6S31tl
	 ed/FtGNMDgSiLtzwUr7PBeAol/XoMXISiKDsQWQ+OLTN228YTxpkTvFPnLouua/ZLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrK4Q+wv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AE606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrK4Q+wv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE91F000C0;
	Tue, 24 Nov 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534622;
	bh=xP2PZrRzRQskbp3UIKwWTuWy1Ghia0qerPJ0DlNpJYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrK4Q+wvIKG14ud+R+6Q3s8fJX1cOSsHoiAnPzbBOnQDp1P64o4KxtxlV3DJK+eA3
	 paJihIaYZr5X3yUgVFrHdbgG85xByonZuXvCnEyowI5JMefBN+Zr+r8Mxki7fF0eTu
	 fzZbk5jadXOJn12kBiYBlKQbR1E4J8Axl42EeEhOOy/Fres8/Bmtusd+xLrqkIiO9f
	 XXpA32TGpc7wGJiAnoMg2p7SOjHv7H7fH9qQjySlPgVl4MTtQ5n+MDRyOLHGTiTRf2
	 PW1JUxBA7KH6jxnj6gVMrmzQG3ecPTrEjjB0e+PpZ2XMAbo8II0HjX5NdMPzvEA2rV
	 JZ4W1CJL5RLcg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 23/27] mm/damon/sysfs: implement submit command for report producer
Date: Tue, 24 Nov 2026 07:36:29 -0800
Message-ID: <20261124153636.91854-24-sj@kernel.org>
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

Let users manually submit a report of a data attribute for a given
address range of memory.  Let producer_state receive "submit" input for
that.  For the input, generate the report based on user inputs that are
written to the appropriate sysfs files and submit to DAMON using the
core API, damon_submit_report().

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
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
