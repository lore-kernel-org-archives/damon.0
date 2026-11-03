Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667591;
	b=X19SkDLz01eZnreL6J//qx0gjRSeusYjXv4x3eFjPfsXDnj8LlhJbEoHmbJkbdD9VZrK
	 FapcB2ieZTG0pMAiR4o0qTzr87+Fs+/EQLvlWH7qJhhYpITQRw1ihsmVIXDiA5XFL6EIz
	 vmjLPQAr4898CJSEb8NtoQRkU1kcnRBJIhSRPKrA/gZ76BBmqa79LB2AFHAdHiAH0jQBe
	 cRSErH1oQKkUESqz6XXCkLZ+Ti7e3lkGj5pb2cVcGMeYl3hT6j7vCPAXAoBBkxxHSvbDR
	 hcPSrIFNeACnu5bQ8QFlCsXRADRrXJTtuRDHBs1WXFZGRdhlH22COH2RYgpYMVLc+qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6iRmnLuflCl7MrpW9F1BaNAFdZpZANiW6H3XK0CDxEM=;
	b=As1a9wY920F+//4MWdouh3dhYymYKGfuCu0yGq7q+tbU8y08rlolx3rM7LHURfMe9jPl
	 WUinQGSgRY5wmqe+coZRlVuEuSz8vq96vs+T06WHSppNSwbqm6DuG5LcutHyynsk666TL
	 yq455qxf5MirC3j4JNgKKL5sh12XJUP/S7fLNcKmwf4Z8bUsgAigsGyzIAFr1ze4Cficg
	 oAOxl0vLPHv9hzAKSyJVZwcSdM8B54Wgcp+eTPHjzx4tismw438bamI6jXDKL0sZMmw6H
	 +0/XU1zsiLuXEtltvpcM+93kQRo1v6foVSD4UqIhzaxdeVDismSUFVu1twB0ag6lBPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuKmAoxP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B49606D812;
	Tue,  3 Nov 2026 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuKmAoxP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E701F00A17;
	Tue,  3 Nov 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667591;
	bh=6iRmnLuflCl7MrpW9F1BaNAFdZpZANiW6H3XK0CDxEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuKmAoxPUZd1e7NVeSBwZx2Whlycgt1C3G4NUbXqptUWAcrd6tI393dYDWQ5NQPbv
	 HCbaS/JDXyVh6fE+bZREr2FwtnXUCh09Gk0HJXKoCGbkbAy5mwAaGONKY7VscihMzh
	 iJJ4UfOovxiwJ1k8g+HmWt5EunQy0yjhx1oaYYotm3ozcOQtVQqTHOUAqMNHmS36Oa
	 /dSHq86YJ2xk9xwuGXD/+w/bo8SRDanqnZ5s4D3GhVVytqd1AvX73HAhlGNi+0jNWb
	 aq+LkQui7L8doXVYbxcCQ/6dpkmVIFBN3c1WMetDaA02IqrTsZg74ToWpLl1HdSkhC
	 lvAx7YSg9NUWQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 6/8] Docs/mm/damon/api: fix verb form
Date: Mon,  2 Nov 2026 16:59:36 -0800
Message-ID: <20261103005940.91432-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

It should be "All you need to do is include", not "including".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/api.rst b/Documentation/mm/damon/api.rst
index 08f34df45523a..1f330429b486c 100644
--- a/Documentation/mm/damon/api.rst
+++ b/Documentation/mm/damon/api.rst
@@ -5,7 +5,7 @@ API Reference
 =============
 
 Kernel space programs can use every feature of DAMON using below APIs.  All you
-need to do is including ``damon.h``, which is located in ``include/linux/`` of
+need to do is include ``damon.h``, which is located in ``include/linux/`` of
 the source tree.
 
 Structures
-- 
2.47.3
