Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E34552956;
	Tue,  8 Sep 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878955; cv=none; b=RBCZ3+QsAi1roXgbJU5AmTn9MBbdCy3Kegqcvx8JPCRqPDzUSeS5YPA1rq+J3kjUZ5w9WMTur2Vr8mIavlSPQz+3lvVEFrHQJvgPRPSNCniPJIE+6ICseW1RXSH2Fw/C45xroewVD7Wl5b5Do1s0+su2qBuFZpFU/lWiyhUjhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878955; c=relaxed/simple;
	bh=QlHdIohpZXIdw/kroev1f1mzjcviMGmQo8zyFX53VBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEknhri9APIdxwt7B2qDAqeAI9ACUa20QrP/ey5QkooxsVREtVCsVMwFqTLX8vwvw1NM5BNFO4/2mSuV6HRGFHijoR0qByV/IH8oW9zjRjsP02kbOjT2iypiRkaPTXnTB58LUZQCQ5wOxyE7Y4p66VK3IyxE2PbvUaIFOxhU5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otzDxKaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otzDxKaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353461F00A3D;
	Tue,  8 Sep 2026 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878943;
	bh=X+99Jcayi+nWYM1zL62pmOjFdwDFaLWV0ywtPPTSgRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otzDxKaMsEPo5BrTh9lku30PuCzo66+jUoEmpvNdOMJa+mEV0SykNq9Z6gLqExV1h
	 cOZZQxrplmUWtetw0kDKb03j1d8R0zTPZTB6vRkvls2cQZv4B65o38aZMrKzbAbCOu
	 3aveOxcjSZYbfLJf4tDSjdjbBBHPlzW3F4u7cSQ+YmXC+Upe06IiwTXJCGaBBu+ezP
	 yVxQD9Ms9gBNq+fPKvVwN09Gv2HwPG8T3MlGY0PsXJawghAHcT7+04eHJUGo4qFYmH
	 /FkWj5w/Rkaf38nZBXKNILzS7iinjA7szyqzaKSPydOajMCmaxycC63gDVj7785jb0
	 u1AIDhfMppEzA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] mm/damon: support access monitoring of hugetlb-backed memory
Date: Tue,  8 Sep 2026 07:48:51 -0700
Message-ID: <20260908144852.104829-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908135156.97481-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series relies on atomic hugetlb pte setup patch [1].  Without it, applying
this series on mm-new will fial with a conflict.  Because of the fact, Sashiko
also failed to review this series.  Sashiko reviewed the previous version of
this series and found no blocker.

[1] https://lore.kernel.org/20260907170358.100168-1-sj@kernel.org


Thanks,
SJ

[...]
