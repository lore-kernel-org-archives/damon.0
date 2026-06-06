Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B612FF69;
	Sat,  6 Jun 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704875; cv=none; b=MbidS1h8Lp7xZKsxDnFNYDqlvuH2LRDmsg2uMA+EeK5EnkWu1au1KWsOV1i+PrrKOtCvQsl7dWWoGi7xWpaEAysbTUrIiKQFZea8DrUwoMzf2m/dIEiD3GfO3EAXaTAseKGUXXP/W2NyTRxld5Bo7AZ3tLDOPCAajINsdtzI574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704875; c=relaxed/simple;
	bh=aUWkPer1TQWZJ12pm80/tVpN2AgNWkLtY5Cc+wXE8eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBA0Zv+U+ZJ5dTBvOYNCSsZmomPnMz9Gl8YZj7YhvsS9TkO17Z4niv4Cnm0eWif8bjqyVuDNTtNQLjioDcax2xKIL5uv1Q2+gfIIaSDrMz+vVCYlQFY7AyGDUyc1LyjL8YIeLTWebygtNusanSPGdJJbjxn6wDQ9ivoU+d/5TEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkWA6tH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkWA6tH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401851F00893;
	Sat,  6 Jun 2026 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704874;
	bh=2J96v+2qYDpkIgFeGdx7Pd22ECpoED3Ti9QEkLALI7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkWA6tH2aJAACRpgfCpLj5xYmf5yi3+m7zVtfAnv4YUpe/dByCjyjhQighgfqYSz/
	 0URRiAWvfCFrPXEDC5Amv07ReKrpnNVRFzIYCjX968cS/mXdItTAp9K1Q2KKYySoBB
	 0E21ounHpT7VUzFUbagRp+sedEk+9qTA4y1bCF8LRCOPSt25UpdPyJSkbtkBd+9s1p
	 VV//wGshhVuhjB3KG+xi5NIBrC/zffOycHkV+oNhT29I+rnXMWgIBJkkYbfkTr5hsm
	 m4/dmryJtEm7M3aeuHP3ljH6Z7bKDTfe0Q+EGqU8gDupY/q45s646hIi9XklAcywh2
	 VFh2eDw962Fvw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Fri,  5 Jun 2026 17:14:30 -0700
Message-ID: <20260606001430.88471-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cc60cd6b-d841-4b5f-b3f8-b5dd39ea5808@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 5 Jun 2026 14:00:09 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/5/2026 3:44 AM, SeongJae Park wrote:
> > On Thu, 4 Jun 2026 15:03:34 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
[...]
> > I wouldn't mind ignoring Sashiko's 32-bit concern, but do you have any opinion?
> I just answered. I can cast 10.000 to unsigned long. I don't think many people
> using 32 bit systems will use over 1.6GB of huge pages, but it makes sense to
> be safe anyway.

I'm not sure if it makes some change.  Let's keep discussing on the Sashiko
review thread [1].  

[1] https://lore.kernel.org/20260604151932.93C431F00893@smtp.kernel.org


Thanks,
SJ

[...]
