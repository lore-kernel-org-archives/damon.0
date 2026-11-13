Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547040;
	b=H6EO44ntzjXtmZqjHUJI+hMbojtYcW2GCp0kZsclj6qS5m6225drHmqClFBlxpEWaMpH
	 /mpI6ie3IzG0TDt2cxyGJoaUJvWpV+J1jp65x/nGWPKgznwHytIlhPV9YGE+/MMzU0iAZ
	 Dg7Hpa+qEWDmY6eL6ZJY/nuiH3p/kPiWEsLdCLVzGFPHzngf25ZMBPtoR/aHTJ9df4hrP
	 eSzUXpY8yCzy+50d5wsBePSTQUN0MZ9EuJHekpTevR6qqWwA/6fqsTGtfTpZOD2K6+MrE
	 gXziYpX7UyRqz7oeWGsvqmOxgQQKzG8SUs11uFYMq4VoAYaJ0YVE9JUBj82KAizQLGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hDPWmvInaWp2wgeM0od2Li5jTmlC0VSnDu9Tp3ujlp4=;
	b=cmbHg7wxSsuvkv4opYD9fkrH9gv8nGgFWxkAZ9vGVmp83yHkGNltkekvyMZ2fr4lAbpx
	 FW5ttrMbRBt58E2jvNogvj98yUx+cbLeQxoH28SI9QeTmOVXg2aiF+kHrMd4MIT1CP1h+
	 ysQilMsi6xUKlnBx0TvJehLqzQJXt4EcpNOvt5gB7dIQrn5xE8/VsuPdbIpxwsuSodRvn
	 rZuXb0Gg3aogWQFh6fst45obRkpUqBAbIKSJhb4TxaR/8A1UCx3fG0sw9wp02oy/O78MJ
	 I3uHPdzs0xHzYnX3yPcP55jCit/TXUeE3N2AsBHKtIrfYaM0iJN2FnMXdPd/HanUc9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+yr6W27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E55606A330;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+yr6W27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2863B1F000C5;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547040;
	bh=hDPWmvInaWp2wgeM0od2Li5jTmlC0VSnDu9Tp3ujlp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+yr6W27/wZKaPZnZaFn/PbqcVmbapL5L9VOqS2LQ1Y/ufYLqSwa8bb5psMelW6nd
	 OzuBREQ2t5tcz0cd2agIsS+Z3j6rqTpCKT2ta1PyFTY+6ZzU0P/rP8wbt18Ki6iDYT
	 pZyYw36lhgjICmVcRdaWGwRhwOEkIPY5org/KFyR+vKXxtArmZc08fbyaeeOGIO6dv
	 ws5Ys4ETf7CSEjHKdPVSeJbPsDHJ1373M0zc4MSoyZBQkmaQn8z4WhD4dTo670+jEI
	 fDdzWnZK0JLlrfFpNfez4NAb6iHqNthLYxzoOrDu0LBjiiP5mgG6X7MDK853Y2TlND
	 VQWR7rU0VlfoQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/ops-common: implement DAMON_FILTER_TYPE_ACTIVE operation
Date: Thu, 12 Nov 2026 21:17:08 -0800
Message-ID: <20261113051711.89274-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113051711.89274-1-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
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

Implement DAMON_FILTER_TYPE_ACTIVE operation.  Use folio_test_active()
to show if the folio of the given memory is on an active LRU list.  The
implementation is made on ops-common, so both vaddr and paddr gain the
support of the filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b9571f53e538c..2216a0023154f 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -574,6 +574,13 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 		matched = filter->range_min <= folio_sz &&
 			folio_sz <= filter->range_max;
 		break;
+	case DAMON_FILTER_TYPE_ACTIVE:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		matched = folio_test_active(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
