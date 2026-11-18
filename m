Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968560;
	b=HBThjQGJh3EPOgY9Jt6u6k1zHyEX2HuxiSJN7eGK9Ay6RnlmcAOnerCwWternfT8z2qj
	 rjSTLLY+dYlYm/oZus5kJvmcMs1s30y1oZe7VRvVzOyXytbHnGQQxZnj3pyxDqkHpih1p
	 nvWJKL1t8p0LbfQixQJznOH/9p3RBfnMpurcH7NZivXJbTW2BPpv9nt0+W6qZhH/QDE5H
	 UowhjvN2WyPSwYETMntPRnYfWSTTutStqGYNlSkVTSAewn/fbJs07XIqcDD7FjJDG68kD
	 TLK/ERpppZVqc+BIPZ8blGrqF2zktSHMvELDNrtsrEGXEgzWYHvCrzAxPe24YkBCISw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	b=QMY9MWhVQabRx8HSiDlZxX4kKgSKYiiCXnftwIN3/qNPHSiduQwKyk+3R1YlJttmd8fG
	 DNRpLE6IkvR62qfOhbpcOvnmbgBYK1Lr9W2ICDH8D5i7xdIyumWLZAXkFapGPV5fKzWha
	 iah8vp7B9nOjrc/e0ojVq5wrL+NJJEPBJw5NCrW1jHTATG3yP/zSZ4NY6/OvlC4fOQJIW
	 DtFdW/JYrRurQizSBhqj3fiTmbYQ8QNuec8FGWD8ZZmaAksK+xCln/vbq45aBFbN3GH5V
	 w9y/bqPJE/XlArThjlSTAZWZCMsM3m8XtDRWwCqnSiTLB3LMYgCCie42qxvIudfNdVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHm5HSyh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE5606B54E;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHm5HSyh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F71F000CD;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968560;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHm5HSyhwMzZkeCIUnHHrqzrm1dMW9NzjsNkGz1MfHu7Os/j7F2a6IijPEQhyTlOm
	 xq2/NQUTJcED1xyjylBhRvOLEjUjT8xlsJZPNQupGkM6bRD6ZumzdOmSR/agDKT5ir
	 PxaasSHU4ZioUrIdHecpcSQ0yVVxk53b+WAYrQvMrXLwTLpYJl9oALOy4jsF90v/Bz
	 WgXAp4/r4pMI++5vQpJGoPvQJ6TWg8OusPot+owUkISBW3ftjsqH/dfHznkhGAoWAs
	 J+C+RO4sy578Qe7uLTlIMw9C3wv8BcNK5TtZq5K/W3uec26P0+jSHvT0ZikWa7lAMY
	 hZIRnXkq7PsmQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 23/27] mm/damon/sysfs: implement submit command for report producer
Date: Tue, 17 Nov 2026 18:22:18 -0800
Message-ID: <20261118022225.100659-24-sj@kernel.org>
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
