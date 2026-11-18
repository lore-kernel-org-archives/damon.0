Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968561;
	b=hpS7LdrTlB3WGy4JpSRG7LRSqAES7QCNl9dlWLg5jzAzWaBggJa1daXSICkjOE1ogt+q
	 3K+ll1FSltgD49NwsyUmsBZd8NoYzMWuSiY6FFZ63KtrEfm6j+TK0V251P0d+POW3acyN
	 C+S4KuHh6bam/pEIdhpOn7Xp4QHqaYpTEbGwxOg9yW+vurnCXBbyQ+al19UpdWu4Srwaa
	 POIMxXZMbBFP7CBWwnuqn8cRPnDDA7Ox1a6IXctnph+NMNsywLTanDYV0THxR5TVk+yYF
	 A7v+Ek4FPqWYKuhB3QveTJmi5vKAhyKiOnDDfDQO3NUYBbVTaZ1g3q0+dp8mG3oDCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	b=zKmlrgoOOw9xQwMyNe3FzgVWg99AOI3RLfyX8gdvCzk43ovKtyr4eprPcqMaKNrBnhea
	 iXzcQzbTT//Fh7ev7IxYYLwVQjxLtxN9vdzKDNwkcfdOk8+9uAruGGXmjjy+buoEnE5/X
	 GM13XrYVhJOJ2begu9RuZEHIqDyIJ6vStk8T9n/iaEqmt0S/pRX3a+fa1aGzXgluFqQYb
	 dcvnTkOEg347atjJ79dZQIYsb9ReJBABv734ao9QpFbSS+nVSbn5A1DOAcyfO0E1mubGK
	 TfexgKFPDpQG1tBOjouudsY/uOkk4FE0VVTjScg6x/s3i9dloMzjri6CU5LX0Uyeoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drBum+B3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55A606AF5F;
	Wed, 18 Nov 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drBum+B3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7C71F000C7;
	Wed, 18 Nov 2026 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968561;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drBum+B3Y0XcHAYkyTKnN1X/Syvw9Gr739WSHwCzcqWKDtRr21TQv5pr4eQyOLkr5
	 SwpKmDVYFOYUD98T4KzMAyoyzWOsm0vETHeIAkpM9HcuzBld5/kJj+WUYWiVgEKenS
	 oJELJLWrQJNGJyv/9xmLN2bUlVD+KpwwNhsZjZEFv1MHsouNDFapjtwUGr6Bz5SAIt
	 eVqjdlzLl4fA16/EASL15TzqbptfEMCDaOXqBv7qXsUOm78q0C/c5F7E2VUonLMVuX
	 FjMhzUaIZ6nIT7PtnHg7bI5cJ0DBmM/R6qR3Yxna0djdBT2+jbR3OCiVOh74UG2uMQ
	 tYgcUvNVPUhGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 27/27] Docs/ABI/damon: update for user_report report support
Date: Tue, 17 Nov 2026 18:22:22 -0800
Message-ID: <20261118022225.100659-28-sj@kernel.org>
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

Update DAMON ABI document for the newly added user_report type data
attribute report support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e558dd4212f2c..41a4ce49fbd35 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -722,3 +722,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	A file for requesting actions including enablement and
 		disablement of the producer.  Refer to
 		Documentation/admin-guide/mm/damon/usage.rst for more details.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/addr_start
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing an integer to and reading from this file sets and gets
+		the start address of the report to manually generate and
+		submit, depending on the type of the report producer.  Note
+		that the start address is inclusive.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/addr_end
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing an integer to and reading from this file sets and gets
+		the end address of the report to manually generate and submit,
+		depending on the type of the report producer.  Note that the
+		end address is exclusive.
-- 
2.47.3
