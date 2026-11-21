Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294828;
	b=OUzJR2xxdt44674w8Ch1pAGqBERKXIYqkxLQJPaj/S9nniAMTw5br4YYvwL9R6oWT9fn
	 Oh4q7urJbCKomt1s5gWs9n4C4lA7TC0gOb/e3yJzyVga3eVnEn6y4UFengeKHd9kNMLlf
	 n7Cj/ujXNF84tKx4yVF+vUMhZoZymWi7ftNqeYSHoXO/zkHK822OhsZxk3n71a2Bupb6r
	 sVvXGe/FwMEYJeuXufhvVbsYrHXXfd7qy761UYs1XRW3XLDFcSX2Uugy+oj0Zq3WWObEA
	 JRuHMAfpz+pKjLA4LPG5+cdFOF+hYDPLAcK3bpbFg30t2MdIbL8csXNaqxbtPVYY3ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	b=kS2dc6+BP4uwdtXDBeVKd9DlGcvO4xnro9YkOROcQlpL2AxllzSSOYj0WjTUqFZkORe7
	 nBWz3TDyST0MvdJNrtTE+hq9k3Fgow/JRcU4qARwhBRv98uNecwrG7eL/7LxyexwXpPZ0
	 BvTEBxL4EQ94XHVMJ4TuP2MpdVI4VPH7kYtim2MhvTwkBC6YBYbz8JNxQXX/dmtMa6CEE
	 7g1rcTI31DGov/6ME6INNrNSU3C9V/z/Bu9SyvQtkwjCRGfZtbSV58OVBLndkzr5Bo8C8
	 oZI6qc9P3NJls19xgglYrSuu34iUhQ5WpyeGizmvjqQ37FJAAmzTqiJxUgBmHbYXdmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoZ3pd5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CE606A332
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoZ3pd5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A201F000C0;
	Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294827;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NoZ3pd5DedxSdMbRV5EdiC19XbuqSRej4mObs9VCdwTj+8gbgxUF3QWpALHpZVM3H
	 +f3XAUwWm+Sug8JQfcOPFJ8ogCqKBYBZ+YFAIAv6JBwFDM6WTwMSSTqKB7DLnBbmxu
	 7V9vZdnhMuD6TtimhatbZtEEu2CS66RonZ3jgK6NGRENPHDtfd32HQNLXp8UpYA9ad
	 ppSiyhhs/on3PIJK1ARMyv7yHZhj9R9IQLwK4Ab8G4JQczAkFIVQZ+d5Q6KuzdaFaT
	 m+zWgsCjwHgNZoJI9iY4KvL3O/HJkGDpBWp2ZBds+zFxy51Ozw/kU4ER3tpYp05y16
	 EDw7KQtlAxa3A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 19/27] Docs/ABI/damon: update for REPORT_MADE probe filter
Date: Sat, 21 Nov 2026 13:00:03 -0800
Message-ID: <20261121210013.130397-20-sj@kernel.org>
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

Update DAMON ABI document for the newly added REPORT_MADE type probe
filter support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index c9f718f126c70..e558dd4212f2c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -233,6 +233,13 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		hitting the probe for the memory that satisfies the 'type' and
 		the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/filter_report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'report_made' is written to the 'type' file, writing to and
+		reading from this file sets and gets the 'report_type' of the
+		reports that this filter is working for.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
