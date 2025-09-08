Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4D21578F
	for <damon@lists.linux.dev>; Mon,  8 Sep 2025 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306195; cv=none; b=gAO9QtuAScnC3jcfqgU09BwCtBvRIY2xVP/ZN1AsS2iiTvoS69Oky9uvkDtMA6kFsDhY87Qe/Mkmwbq/cxJ6MLexPQn/KZmS1erl0jr0W0nvfdLAj8HzQPj4i7iOHlAn21Tk+ne630A3mPHzSFMUG7eSttil3q6TuNtTnwSN5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306195; c=relaxed/simple;
	bh=+7vRA6aL3xmkwb8NX4YSuBqgZtBqwL4jdovVxNxRKiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2dvxkTQiu43ez36Qaa26K+CHGz5tH6Fs0YSJrmtOf7yDh6DcsLCaKw7lRyXg2G7t2ipY2krCkNOVXOuT5LmgYIVUQ9wijEKYdgV723BfuY8uEOhfvJkDiatsKZfMF6sP3Is0t0zXT3wP9Yt/o550b0YNPel3lnmiA6Mc8x2ovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-19-68be5d455b63
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Mon,  8 Sep 2025 13:36:18 +0900
Message-ID: <20250908043619.1085-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250905200741.23489-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsXC9ZZnoa5r7L4Mg2+PhS2e/P/NanH46xsm
	ByaPTas62TxebJ7JGMAUxWWTkpqTWZZapG+XwJXxqeUuW8Fy7orrh8waGPdxdDFyckgImEis
	bG5khLH3rl4NZrMJaEgcPHSSGcQWERCU6H88gxXEZhbwkji/fy5YXFjAXmLDp3lMXYwcHCwC
	qhJH53GBhHkFzCWuvdnEDjFSU6Lh0j0mEJtTwFhiSuN2sDFCAjwSrzbsZ4SoF5Q4OfMJC8R4
	eYnmrbOBxnMB9T5lldg+8wcbxCBJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECg2tZ7Z/oHYyfLgQfYhTgYFTi4X3QvzdDiDWxrLgy9xCjBAezkghvERNQiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUAyPftninHkvHEI3n
	krd8fSXXpoatKK24/L/k1HZWW924V6lu36eZvOm9+PtAklts/J57mn8ezjU0eHu6RnWxuOTP
	Y60frCpOHewSYeLw2trX8Lngdnvw07sPxdfFh37POedwuENjevYa+fKb6+ME9z6ePLH50sls
	QUaDdM2X+y15dM7N2tdqskWJpTgj0VCLuag4EQAi9UTpKgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LhmiGro+sauy/DoPkAp8WT/79ZLT4/e81s
	cXjuSVaLw1/fMDmweGxa1cnm8WLzTEaPb7c9PBa/+MAUwBLFZZOSmpNZllqkb5fAlfGp5S5b
	wXLuiuuHzBoY93F0MXJySAiYSOxdvZoRxGYT0JA4eOgkM4gtIiAo0f94BiuIzSzgJXF+/1yw
	uLCAvcSGT/OYuhg5OFgEVCWOzuMCCfMKmEtce7OJHWKkpkTDpXtMIDangLHElMbtYGOEBHgk
	Xm3YzwhRLyhxcuYTFojx8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq9
	5PzcTYzA4FlW+2fiDsYvl90PMQpwMCrx8D7o35shxJpYVlyZe4hRgoNZSYS3iAkoxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwCheWn0ijcVhhs7XhaHr
	lJYVz7zh+KMv3bfy7OqvKxbufX5YnKHCLfbKieX1Qob6HKKq8g+8Y2c/ZTl32tLhh9R78Rwp
	Zg1Dmexdzx2fSn329dl94SdP2my1x4cjDY7vaeK6MaN6aZi4GIM5Z8vV4l0L//mcsm69Ldhb
	fynr0J3y6jP++TmsrUosxRmJhlrMRcWJAA5hM/gaAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On Fri,  5 Sep 2025 13:07:41 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Fri,  5 Sep 2025 18:08:26 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > On Thu,  4 Sep 2025 20:54:11 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > On Thu,  4 Sep 2025 17:29:45 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > 
> > > > On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > > Hi Yunjeong,
> > > > > 
> > > > > On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > > > 
> > > > > > Hi!
> > > > > > 
> > > > > > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > > > > > I tested and confirmed that this issue also occurs in v6.17-rc1.
> [...]
> > > Thank you for confirming.  I confirmed attaching patch fixes the problem with
> > > your repro on my setup.  Could you please also test that on your machines and
> > > confirm if it fixes the issues on your setups, too?  If you confirm, I will
> > > post it soon.
> > 
> > Thank you for the patch. I have confirmed that it fixes the problem on QEMU.
> 
> Thank you for confirming.
> 
> > I will test it on my physical machine early next week and share the result
> > with you.
> 
> Looking forward to!

I've confirmed that this patch also fixes the issue on my physical machine. :)
Thank you very much.

Yunjeong Mun

> 
> 
> Thanks,
> SJ
> 
> [...]
