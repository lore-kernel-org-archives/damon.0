Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E818A6DB;
	Fri, 28 Aug 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878897; cv=none; b=lAmBwtSqUmQiOsWifgk/Dph23pXazKmpgNdJuzdgkTXXr5snqUtt7JzMIbf1L5pa+TTVzNvzZoszm7rIS5xyGQDwOgRWeUPIyB1y9KtVaL0mkRjJ1uPu8Ix970JOimLtKFF+1IFe4MKJv7a22tmnk8C0p5wd8sUnpZVq/GVKoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878897; c=relaxed/simple;
	bh=bTWp8crSJQB0OBKLFz/g9iZTumHhO6+qw+lqiIyXIOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkzKpe1tUg0YJhpEhHcpS+BZvSd3hK2jcnl02eL3iJ6TSmvgDCFLG2jtws8Rz0iLH13DZsJSWii0lhkmREMF5AmDyTfxDsTLCpmFcx2uKzHbIjpXMBtZmQuj/bRN6cRhjPiA5TaqHUc4hV7/sGn0sTK7EiTHsDQHull2kMwn3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROLCM3ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROLCM3ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3701F000E9;
	Fri, 28 Aug 2026 01:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787878895;
	bh=BzFgSWthSn1we0Ma7fJwP6PBLxyvmi7fGeKff1V6Los=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROLCM3ctzr9S54PvfbDPBmzD8mjjLY72O3eOsMfJsQ/nhZhXPC+9Z4MVVnPG/zDq2
	 tFlleATzjb6DmQSCo5CalpJRxuTFj/pmqifkbROmWyVNRhxeBmpyXBizWuvHotYG1z
	 z35nfa86+GA9GugpezOcM4OottaxMzeuyUEO7wqVcvJcec8pnQGPsDGpkxwJ/FrNZC
	 YvGbP+kEUO8/S4stkjxfjOVahY6TkdxO4R9VL5WhFFjXIGed63FQ3YXsczxzWG46ix
	 UrGTE0FwZEUxLRjNh/qRDl4A58rymUHvbPcGThfwB5yfN6+HyWOKfvPtYuAgH7fvMm
	 afrQDO97oI6qw==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
Date: Thu, 27 Aug 2026 18:01:27 -0700
Message-ID: <20260828010128.10599-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <72252089-0405-441a-a7dc-0e1deeb2f802@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 00:47:08 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> Please ignore this patch.  This is absolutely wrong.  Sorry for the noise..

No worry.  Thank you for the patch though!


Thanks,
SJ

[...]
