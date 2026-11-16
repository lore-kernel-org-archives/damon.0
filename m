Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841865;
	b=QkCnkoHSmT12PFmkG2a0LAD63wBQr5UPsZhx1osvX69wxdleEtNh3Shoo0jWXQsLOCIu
	 d6xCX9wBePiehYS6kko1gGUXvCICngYLavaCkM6JSUVa6OopdQCf4A7bcfsMLqGJBqAH0
	 Nzg3PHVYvdYesi/viKy1El5WEnbOog9G0MT1LfuMaCQesE5RTLWhQ2f6ytIqNRpBQsRcg
	 dTZc1CQmuwmaSAaOs5KT0ZSIfjaEnlCJBDagI3r2f9RU4IU3wyY58nHt5sZLFqLUvSovn
	 iaNzD9KyuE0f1QVbgsInEEe0Nezr0FEgintlCfAc+eVkl75QJ24B9TpKDCL0A2JwL/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qAt5aWJop6Pu0d7LhLCZqFYPYEr0G+2IZf0ofUW/gfI=;
	b=WZuQk1R+7bUxhH9dwxVwlKoASZqR7lkaXTv97UrPqHIwST0edCLtgiPHT7pemmGMfmGW
	 zR3H0hLq9Hq6gnI6kXwdFQtx69DWx07yv8TeFcCVnGDsDtkpulgimufdQm4GJAvGw7Xsi
	 tWHZLkTQMDdpQMEtI7fiNmjgPq0bB0PY3eKWttb6Tj1owIb3+9bcz3kbT3vwP3JSu+Y4m
	 dHPdbyV3o6Lr537P/W8qOhR7APXKFsrjoR1gic7I18GBonSxdcja+okYZBhGCRMvqV5Wk
	 jngmCo5IIvFtnhn5k8uGIHLz9ev6rBYKuzdut/n0kG5cCibbZNDsFnDctArJpgWB8Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oayyYlMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C532606A88A;
	Mon, 16 Nov 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oayyYlMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7801F000CC;
	Mon, 16 Nov 2026 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841865;
	bh=qAt5aWJop6Pu0d7LhLCZqFYPYEr0G+2IZf0ofUW/gfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oayyYlMd88BXip/D3W6vthiAlG7kS+IGPEYdh21vy2cV/fVfMXJCA43m+oCZtobUL
	 P+CfAPVxdXvma8HtULzj6t1wKCV7joPwPSdNCc+FrDxV2XWMDyrNVcs+I8k9DYk2Rc
	 nMkGPtKwhtoofcNlLRO2T6jqGFXONOduUOjLvQaXJj11q+3Ut7HE4SMUb0M8+6Hu/P
	 qEy4pje+8RPkAjLmfdYB1J7nnXMOQfV9HyHmARnmC0+758o7WqaA3umI2Hru9KIcyj
	 4lKIBH0ERyhFHeid6tv5KJ0Xw1BBxyjtMeqEJlOK5Bi831TZR3dzXX34H44Qz48Dgq
	 vjTQvtf9h9Jqg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/paddr: add KUnit tests for addr_unit conversion
Date: Mon, 16 Nov 2026 07:10:51 -0800
Message-ID: <20261116151057.81692-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116151057.81692-1-sj@kernel.org>
References: <20261116151057.81692-1-sj@kernel.org>
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

damon_pa_phys_addr() and damon_pa_core_addr() convert between DAMON core
addresses and physical addresses using addr_unit.  addr_unit lets 32-bit
kernels with a 64-bit phys_addr_t monitor physical memory above 4 GiB,
but no test covers the conversions.

Add a KUnit suite for both helpers, including a case for addresses above
4 GiB that is skipped when phys_addr_t is 32-bit.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261109-test-damon-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com
- Shorten config prompt.
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/Kconfig             | 12 ++++++++
 mm/damon/paddr.c             |  2 ++
 mm/damon/tests/.kunitconfig  |  4 +++
 mm/damon/tests/paddr-kunit.h | 55 ++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 mm/damon/tests/paddr-kunit.h

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 34631a44cdecb..a33f21c563475 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -65,6 +65,18 @@ config DAMON_VADDR_KUNIT_TEST
 
 	  If unsure, say N.
 
+config DAMON_PADDR_KUNIT_TEST
+	bool "Tets for DAMON physical address operations" if !KUNIT_ALL_TESTS
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
index 5b773012a8764..e89cb14ee17be 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -479,3 +479,5 @@ static int __init damon_pa_initcall(void)
 }
 
 subsys_initcall(damon_pa_initcall);
+
+#include "tests/paddr-kunit.h"
diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index 144d27e6ecc5c..9279f0c82be7e 100644
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
index 0000000000000..9839cc2330712
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
-- 
2.47.3
