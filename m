Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148005;
	b=jgEfCGk70m3TE6jfEXw1O6z3izw/3MQQCWxnB6mXWa0Edx1NqMUpVDuSqKJcpELQOTp7
	 qVFtRYHgexajAPo+WSxopCgkuXOIg+aivZEzf+0Ewu3c8QQpb0pxPRk5MvSwZk5xda7kI
	 GzzyCJaEiHEa4xeVuvRe7sIJBYaHcNP8LB5YQEzwYnfUpzQfrhKXCI3sIuwp8hiLboE/+
	 yADtrpuJReJcrxT07XWwi9OQ/Jj3nYHPDOOfctSO8wrJCauM+Zhd9ePyOdj4PIhl20YJH
	 MCuOARtw/U7bK9D7kVscBh7d8oJbXqj6pgbpAr3RRh3KD1WgHraKGG8r+67hYpfQRHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=anI1ChYfeZjCgF1xgVXnWSsm/4XxjRJS3uHT+I8cNNc=;
	b=UwLb/62RNaXJVevA/ocu0v6i773br9xZLWYaX+cg9ziBl8AowVUiZH/qAInOLLDJmZ/E
	 OR2ODebj3H6AiS5U7sMB2qfXotD2f59O6Vzo8Rj0s2iM9qhPdQLjRApTiv0jf0WTtvxf9
	 fJwuJhUrsdWVaRuGcIi9J6d/CTVaYC0Dkp+tLGMC2Oj77YH+WrFUXjrIHHI2olCED7n3M
	 ZgUsIwRpBye2B1zSSF5Wu9IifuntKZwMLGy5mVGLLC9Oj/y8ACTLSdqIAgHSjhArDn2QT
	 KvzO9tu7ObTwr9XZJjjum2hBbcuRogGK4leHhN4C8xAHyWLdbNL7TDFQugd9Uwb80hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8NzjP4y;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA47606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 14:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA47606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8NzjP4y
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f2f262b19so127526eec.1
        for <damon@lists.linux.dev>; Sun, 08 Nov 2026 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794148004; x=1794752804; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=anI1ChYfeZjCgF1xgVXnWSsm/4XxjRJS3uHT+I8cNNc=;
        b=o8NzjP4ygSVaKMu0dNCXHsUrXE0yMYr0MlqVlr/52RZRqrCpxWoc0tGT6xxlIdou1+
         +t++Kl7nGTCJa7cCr2pn/WxufflxWdvdcjYpLoN+Ws1+XqNCnLSydUa7ZWL+v9AKBN1e
         BfwVmwzCCHpQJS7aiPs1p8ZXWbLO6Hrfww3ONwP6V++rdKfVowpc9gnzKX8JTVChDKp9
         rG8moj21dQwqPOYoA7hUMHGD0lXYJ+XHvFGg2Z6zwqkEVmxtl0MLDXRAVhqhgRiU+PnW
         RB4NX7zMnUMn/2wlLCplnNDq6kMQVdJgFYgzy82VQd4INtX1oEpT6bFyDFf3N/Btful2
         P5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794148004; x=1794752804;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=anI1ChYfeZjCgF1xgVXnWSsm/4XxjRJS3uHT+I8cNNc=;
        b=RJPa0unqdI1C0jYdAi3f5pCIxxKlCQ8J0pgvU9FRH95xVmMayFLCcoY1J8buvVoCXR
         lHCeI05AAYxsQRiRAkgOoEGMNeKVDWpFaWqCqfAE+PDlVomKxt0bL6caDHnS4rQUw0fW
         1Pmc+byzFDowCc+MzcFlkad/c4GFWkIobp4KEsf5YeEJFazjYKKmiNOxuaC74rwHLUND
         v0pGNV/h5eSt6T27VQb9OvgPTKtWNlOt6Zoy7Y8pGR2bLwmwIJoI+8YdWS7sT1kSYoO0
         UcdRl3QtAZ0ASWLa/wk5tgeZqw3lUxJgUQBiuk9NcDeW2QV1afpaOgVeJUM8wfSNePPO
         hmJA==
X-Forwarded-Encrypted: i=1; AL+hErFZH9Npk+o7bGKB51XGa9dPK//MDdv/beJK6Ateu3YRTZaGDwZ2U+2Q+SM9UX3IQzYB4nL4ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z/kwaYRID7tVX37iqWHJ/XXhgsssnAvLSPoI2ieOrYZLBjpAVo3
	5pt2b4CsglsAGVyIO+P1QJZhj/Da/kDQlh5/V76CFTN8gyGdHhVE8Ikg
X-Gm-Gg: AYBFou0NjK4js5282pnO5m+Cox0ttKcaqTvyxvns8zSHvXlGSzyt+h2IUnoji/bAqwd
	Xh22zKOF3LHFUail7MjEjIvSmkasarJD0YuGOGCf5SkE440KvVbPtVseVSO+k8T7xFTO8KPFlTL
	3HB9iP4Q5TCjokHhlsXu5BluDJwwp6KtaX2xjFapxwqHIOyDSEBBNuDUGKvd6M3o0BCUuv8lPii
	TijC9w7ky2bxG97mJfMi4go79ID+JdIQrTmernoupPThfESO2mJGyH2pViOXdlIbcQjpiExCQjX
	E4voULNXi/m+5bhC6YMjDpyE16ptEJ5BBbxmi0qEopdfyQNdgO7G8cPg9vD1LZPfZ/bk6Rcd2F8
	jkkafOQZdg730YSEaTPQ+re7NUk4+EkRnN061mGb/9awcXQ4njcpW2HOfDH7RXPZZ6pR7CzHAcB
	BmjPUrRzmWEBIIqL0mFEwF1WynDsq1mFxO3sFIcIVM1NTeOp83+uioGG46PUjUqz0NTIjjlISCO
	7/O47hbLpJ18tPLz31EnSKmsviY+xYJcLnttMciWGX4Lw0elxV1o1Sql1TLkjVW3uH60QPdfhTb
	sW4ZIOdDa0hNLTE6S8k9Y0qCLurENY2dyeM/idotPs1a3dJWv1hZGnfT5/NnHzAs3t+YLqvEJ4z
	J0UA8LXlpetI3Ulz/8XIlaUDaaF1yqo9H+EuHGvgs0h33PNw=
X-Received: by 2002:a05:701b:424b:20b0:1b2:32e1:3bb4 with SMTP id a92af1059eb24-1b39fed71a0mr2656735c88.18.1794148004300;
        Sun, 08 Nov 2026 06:26:44 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771e5728sm5601098c88.16.2026.11.08.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:26:43 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 09 Nov 2026 01:23:46 +1100
Subject: [PATCH] mm/damon/paddr: add KUnit tests for addr_unit conversion
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-test-damon-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWN2wrCMBBEf6Xss4tN8P4rxYdctjZKtiVJVSj9d
 9MEXwbOMJxZIFJwFOHWLBDo7aIbOYPYNWAGxQ9CZzODbOVJiPaKiWJCq/zIOClrA5aY2SV8ldS
 yP5MUx4OlC2TNFKh333LR3SvHWT/JpM27LbSKhDooNsNWVW2V/W/33iPTB9b1B4FX6YSyAAAA
X-Change-ID: 20261109-test-damon-paddr-addr-unit-kunit-b2f7e2154de8
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
X-Mailer: b4 0.16.0

damon_pa_phys_addr() and damon_pa_core_addr() convert between DAMON core
addresses and physical addresses using addr_unit.  addr_unit lets 32-bit
kernels with a 64-bit phys_addr_t monitor physical memory above 4 GiB,
but no test covers the conversions.

Add a KUnit suite for both helpers, including a case for addresses above
4 GiB that is skipped when phys_addr_t is 32-bit.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
KUnit passes on x86_64 and i386.  Selftests pass on x86_64, except for
damos_quota.py, which is flaky even without this patch.
---
 mm/damon/Kconfig             | 12 ++++++++++
 mm/damon/paddr.c             |  2 ++
 mm/damon/tests/.kunitconfig  |  4 ++++
 mm/damon/tests/paddr-kunit.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 34631a44cdec..6f8722fcf464 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -65,6 +65,18 @@ config DAMON_VADDR_KUNIT_TEST
 
 	  If unsure, say N.
 
+config DAMON_PADDR_KUNIT_TEST
+	bool "Test for DAMON physical address space operations" if !KUNIT_ALL_TESTS
+	depends on DAMON_PADDR && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the DAMON physical address operations Kunit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 config DAMON_SYSFS
 	bool "DAMON sysfs interface"
 	depends on DAMON && SYSFS
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b773012a876..e89cb14ee17b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -479,3 +479,5 @@ static int __init damon_pa_initcall(void)
 }
 
 subsys_initcall(damon_pa_initcall);
+
+#include "tests/paddr-kunit.h"
diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index 144d27e6ecc5..9279f0c82be7 100644
--- a/mm/damon/tests/.kunitconfig
+++ b/mm/damon/tests/.kunitconfig
@@ -9,6 +9,10 @@ CONFIG_PAGE_IDLE_FLAG=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_VADDR_KUNIT_TEST=y
 
+# for DAMON paddr ops
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_PADDR_KUNIT_TEST=y
+
 # for DAMON sysfs interface
 CONFIG_SYSFS=y
 CONFIG_DAMON_SYSFS=y
diff --git a/mm/damon/tests/paddr-kunit.h b/mm/damon/tests/paddr-kunit.h
new file mode 100644
index 000000000000..9839cc233071
--- /dev/null
+++ b/mm/damon/tests/paddr-kunit.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Access Monitor Unit Tests
+ */
+
+#ifdef CONFIG_DAMON_PADDR_KUNIT_TEST
+
+#ifndef _DAMON_PADDR_TEST_H
+#define _DAMON_PADDR_TEST_H
+
+#include <kunit/test.h>
+
+static void damon_test_pa_phys_addr(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, damon_pa_phys_addr(0x1000, 1), 0x1000);
+	KUNIT_EXPECT_EQ(test, damon_pa_phys_addr(0x40000, 0x1000), 0x40000000);
+}
+
+static void damon_test_pa_core_addr(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, damon_pa_core_addr(0x1000000, 0x1000), 0x1000);
+	/* The conversion rounds down. */
+	KUNIT_EXPECT_EQ(test, damon_pa_core_addr(0x1fff, 0x1000), 1);
+	KUNIT_EXPECT_EQ(test, damon_pa_core_addr(0xfff, 0x1000), 0);
+}
+
+static void damon_test_pa_addr_over_4g(struct kunit *test)
+{
+	unsigned long addr = 0xffffffffUL;
+	unsigned long addr_unit = 0x1000;
+	u64 pa = 0xffffffff000ULL;
+
+	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		kunit_skip(test, "phys_addr_t is 32-bit");
+
+	KUNIT_EXPECT_EQ(test, damon_pa_phys_addr(addr, addr_unit), pa);
+	KUNIT_EXPECT_EQ(test, damon_pa_core_addr(pa, addr_unit), addr);
+}
+
+static struct kunit_case damon_paddr_test_cases[] = {
+	KUNIT_CASE(damon_test_pa_phys_addr),
+	KUNIT_CASE(damon_test_pa_core_addr),
+	KUNIT_CASE(damon_test_pa_addr_over_4g),
+	{},
+};
+
+static struct kunit_suite damon_paddr_test_suite = {
+	.name = "damon-paddr",
+	.test_cases = damon_paddr_test_cases,
+};
+kunit_test_suite(damon_paddr_test_suite);
+
+#endif /* _DAMON_PADDR_TEST_H */
+
+#endif	/* CONFIG_DAMON_PADDR_KUNIT_TEST */

---
base-commit: 2c5dafa7f289d760f4492260b0988029aab478b0
change-id: 20261109-test-damon-paddr-addr-unit-kunit-b2f7e2154de8

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

