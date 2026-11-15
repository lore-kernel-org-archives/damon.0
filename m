Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774551;
	b=evxFxbnJVyFW/dMxSOlgbgCEQkT4VOzZTBMuZNfj30H3XTsA8ohAPPnXuKQ3nm8il2F9
	 7EqLlMzOE2i4tjGku2MciPa5J2aiA9s7aURs8stqBPXUeJ9/K924KsW9P3AcEx0qRERnP
	 AfIrdtF+QWvtgLvpN53epqEVFmo6BfDExi+86ELqMcX/fZUGxFPDESuM13YH0U4RlHzNa
	 qRUSVccrKsZf/6nXsEMVI0LOdyoottGjr8jeYN3c3T6GBEV+kvb8JYuY5lygLQFJyl62z
	 Z2mnaPRZFvAgHTLU9w5Hl+nBDoCWBFfsEsh+Q+uhKFCmbIusI+h3RiKi4ISqikEqFwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	b=JVXa2+qtHa0VX74XMpTEI8KyhwqjqVqVm+uXo1uqfAhytJWk/jQH6N3in/x52YoVv/oB
	 D4yvJvNtM7F2R7167KcoirO56qbubvg+QUyVHFFmb13UL5PoZdntt2XGrtpRxIpaPJbuw
	 63MpS2iGSpme3El8XwJvS5EmisXHQhHBek649fzGJ/IusiszqOxMz/iLThl+19jS8n6Fa
	 C9X+67Uux/uSK/BITq71yCNfrE3aWPELQETnwTFRAapeZ+ZlRYwq107lponCK+ivYDtC2
	 wesvm3VYzI7BgIx5MhPpJ/E2ZUhJeH6PUx4QMGCLtFpJiKfF5kTKbZeFKJ/maOnUMrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THi1KgCx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FF606A8A4;
	Sun, 15 Nov 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THi1KgCx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6596A1F000CC;
	Sun, 15 Nov 2026 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774551;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THi1KgCxCL/tbIRUz7DgsnAjLwtHt5wNvzgJivwOw4fEf/fZM7GH4glNvoLqmzslG
	 jKxqeLUpLt4kFsM4nGAncRTmC61p1JP5hbdlG6CzfS32sL+5jbU5zewNXDAfw6oVQc
	 Vclh/Pii1rNz7JCCg+gmQWVT5swKWKdvtA3sq8qEJhgXsW+XuVGNZfLpdVf0cymrg8
	 hWzlNFpoN2vEocHRbokZjJ+XGcFLF8YYDetJ2BWi1WrILp4AtA93fb57B0YHq+bjvD
	 sMiNcLQBk4pBvp0nD8srpKbpE5oI/LMHmKnSY9uVU1826Sl2Nip4cITi8ibu8/QWbb
	 9X8B94TlhuGFg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 27/27] Docs/ABI/damon: update for user_report report support
Date: Sun, 15 Nov 2026 12:28:45 -0800
Message-ID: <20261115202849.99134-28-sj@kernel.org>
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
