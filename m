Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806619;
	b=oaWHo5yokFpexP2vGt+gdlPSysWDOGMB03wrnBFf0m3lCCLHVrx04mCQ2SVYuEqDIlo3
	 gjnP0QrYDlQy0mkmbfcp40TTFgwqanbfghfGIIjAGx0hm+neGFF30oRYtE1xMZG39pjMC
	 U99qWrZoKd+s/Owhs0kl7eLDVFo9L6AtDWAtQz4yr/lBM4aSDfS10gQZQypIJmCVxIcv3
	 a0y42uGWefekzZtRs9jV9ksAcomUJ+C+zL6aL752os42cuosfUJlA4obljzFA9WnLkC2F
	 IO2uEGAQyo1KjdNbD6t1u3HVZkWtVE/ZmViMZpi+7IQjiqXQjYUY4Aoj2MndTH4rgqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZAbRG5nmi0Dlv5LNX/DTzBA1Q08jKkTod4f3ioIPBRc=;
	b=YU5OrQdSrltVZymdug883qcBC298QXQtkehy8J3sNI33m7Z03U9DTo2DQLk94EvlwYR4
	 Z1gArb04tT9jZHN2VwJ0/xDuA9Vam9ZJy6GFFNbraLj5hprokE3EtKlWOksYDg74qUpgj
	 +Ip34ihlm5LadDo8j/AiTo+SGsoZo1lANz5UFfQnN8Q9RmvH1FL+Gd7i5a+khPici3YBm
	 SlVK+hLBY7zYrcAD3yxZsj8/Q81himSsjZ9WmCCpO3ZNjQWGRwUlm1OoRJchBnp5CI+WI
	 fWmELap6WwQ9xO18UiAS22/LJ/9UPio2RSRKX8LcbRHXwAhcb5H/J0/TsUXr4MKkGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyzqrSVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F027606A33A;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyzqrSVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176BE1F00A1A;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806619;
	bh=ZAbRG5nmi0Dlv5LNX/DTzBA1Q08jKkTod4f3ioIPBRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HyzqrSVQ6lDvRB+5carwsfY5/dfrCbS7b8YgwGTw+pBn5RlmJZ9T17x3henuYRi5L
	 Ksvj7DvUvcYMH1RhFINlCUT1yEcevTW0O8n9nf0sERVp83bXd/Sjy31EAtDT0CKbh1
	 DWdMhzmFPeOPkXRQHYMmtVzJqvUofOzezFCJxxHcvsi0zeEvOJhxJFJUWnlVloT+In
	 8OnTcKVBg7bm8r5G1iCyUqHbmuChCdf4WPNAoqussylpLr8/yIo3FiIYo+jK0Wi3Qs
	 fUI8Nj5oJupXDIT2pecpEQSihhf1792kFBD7EB+TJkh2cAFoIRjsEsznE3i5FLJbGj
	 oBTivY+pTJHBA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 07:36:41 -0800
Message-ID: <20261104153645.82945-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104153645.82945-1-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
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

Support use of DAMOS_FILTER_TYPE_AGE_MS via DAMON sysfs ABI.  Add a user
keyword "age_ms" for configuring a filter of the type using the existing
filter configuration interface.  Reuse existing 'min' and 'max' sysfs
files in the filter configuration directory for storing the age range in
milliseconds.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 637f1bd0c950b..230987efac3ac 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -593,6 +593,10 @@ damos_sysfs_filter_type_names[] = {
 		.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
 		.name = "probe_hits_wsum",
 	},
+	{
+		.type = DAMOS_FILTER_TYPE_AGE_MS,
+		.name = "age_ms",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2875,6 +2879,7 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			filter->sz_range.max = sysfs_filter->range_max;
 			break;
 		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		case DAMOS_FILTER_TYPE_AGE_MS:
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
 			break;
-- 
2.47.3
