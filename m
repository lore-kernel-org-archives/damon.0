Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774545;
	b=qjKeNopnKCMXBbjVZToye5JMUubQtLhx302Gpezl7CTX7+gB8Rf31S9KOHEJkkMJsGk/
	 QfO8GWCD07QGbLYswX/1Hv83HrthQBEtRGS1N3W/oSU7cTn/GzeXQYxgLMHFHNs/JDf1Y
	 QMZNhrzMobdztpmmnfWRCpR3bXLNOJGKw86NpfP01+b3RCRaajjEhbfv8qCU2sl2E+xY6
	 jWQmZI17640yA2tpGvNMbR/FBKNh5Cl5HqQsWMDkslIzSLQtJNgilbrXkR7BKWRwufW4m
	 73TCrV+QbhAJllPAb970z7ZRUcMnNgsqx8ACSrcmnrhxY97C7w5T5cTc5fTFdlIljwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zP3OQTBwwZIUAg7M62K45RlVQXlG65CAYmOvuJfQHXQ=;
	b=kRuqwApDAejuvXnaye0bb53koN1Fh3hMs3zdb2aGHFR+wwLs1BZLA8ePxXZkS7KwBSSf
	 X4Qt9aDqnhUE/bbHMChTbBkrqJKpTRXCe5WV+/NDgfOnhfV+SzF/ZwK/VVi3Yb17aN4wj
	 MvWxfz7R6fUXy6AaF1lSmm0pqpmAghRjv0lbAWvK2W0kCwPT8DJxhUZUGmovTsvMscMc2
	 HDf42f+vT+3zqd78cHY/6NjbgawiZpUHgUPwKUcsyjkee87CIO79SKZOdc0jXo5GekXMz
	 Lh0wI+eOwzll7xEWkIV+a/W5zV7H3865s0gIQF/I0VCse5851kiI1vTXdptE1jDkZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViDAqTj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32460A261D;
	Sun, 15 Nov 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViDAqTj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A921F000D4;
	Sun, 15 Nov 2026 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774545;
	bh=zP3OQTBwwZIUAg7M62K45RlVQXlG65CAYmOvuJfQHXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ViDAqTj4fNcGKWq3m5uAhNzR12CpaStaV2OmctpHyhD2VE1y3cZ09WR2UZN8up0bY
	 5MlLqz2jI02tsmPfx7SozKGSrtcg5P1kzTcW9Aco1YNZN3rN6myTnwq4Es/kgoCh92
	 aBC6jyIAiwsAi1FJ7nJIQB+FIeh5W6I8Ym6KBxke/eJR6Xd0oYui0VxqeFhzS5zkqC
	 cF7/nCNk6JtEwWderHTNSJsg49d2PjyqhOZtisHGgmjwjd6hhSsPyS5MategtTqOm3
	 /gc9zRuXYzg8y9Tktx3+lT+9zcm4xxuZ7LzF+QeIk8/CcMDjYwzMXRKckoF0jFFYyN
	 JtwDaUqTTX1pg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/27] Docs/mm/damon/design: update for report system
Date: Sun, 15 Nov 2026 12:28:27 -0800
Message-ID: <20261115202849.99134-10-sj@kernel.org>
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

Update DAMON design for the data attribute report system.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index b676be6971589..e0eb53d7694f7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -356,6 +356,32 @@ monitoring.
 Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
 can use the mode.
 
+.. _damon_design_attr_reporting:
+
+Data Attributes Reporting
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+DAMON-external entities such as other kernel components and users may have
+special data attribute information.  DAMON provides a system that let them
+report such information to DAMON.
+
+DAMON provides the kernel API for submitting a report of data attribute
+information to DAMON.  A report describes what type of the report is,
+representing the reporting data attribute type.  A report also describes the
+address range of the memory that the report is made for.  Depending on the
+report type, the report can have additional information.  The report is saved
+in DAMON's internal queue.  The queue is automatically managed by DAMON with
+its best effort.
+
+DAMON provides the user :ref:`ABI <damon_usage_sysfs_reports_producers>` for
+configuring report producers.  Each producer is configured for a specific
+report type.  Users can dynamically enable and disable those.  When enabled, it
+can generate and submit reports of the given type.  The generations and
+submissions could be done automatically by the kernel or manually by the user,
+depending on the type of the report.
+
+For now, no report type is supported.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
