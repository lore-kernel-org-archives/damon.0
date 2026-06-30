Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC31421F05;
	Tue, 30 Jun 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826166; cv=none; b=HFe2NWyculdYFjelELygJkGMd8Fs3wxHSLzm8xOefvENEopZVTEz5IylxMhe7N9w9P6EEpEwq/uRjA/7WO/CyhDGF+f/+f9Ad0LwPYhW+mYa8zuGPYX9i36VufPDa9RganUCaWPchYpc5u4agCqJsM2Ug3CmEg8VjT0oJfnJ28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826166; c=relaxed/simple;
	bh=W7EGKJxgbZj+3VrD2pgQvTV0in02egkLYsEaLU9JylQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A7vogW3QPJ8IyFmAT0zwVvlNmT8X17AsnT2kITZErunWvSQnMGNihZK7RUO+tUL6lgZeT2VyuaSI1/04OaIPhCVBVUuKeopqDs/Ah6Ml/JqbHcjP4nH0l99Tm/adkHX19k2Ru9Q38fhfO113MNhWkKtnTiKTtSxwYjRlvwmoARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gDOn6Ibq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2Sz2qW1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gDOn6Ibq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2Sz2qW1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 928AEEC00A1;
	Tue, 30 Jun 2026 09:29:24 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782826164;
	 x=1782912564; bh=DmrQNTItky/UiuZPOpMv0EVeheRMp8r3GydTi1+jvvU=; b=
	gDOn6IbqlLF+rTLJJVd2GPPiUPxU+sRFV4HoMABp87+3SwXvfitPGVvrw4g6qQcH
	k2cnZShyeoYlQjukVowJBUY3VMkWGA2T2VbS71TqIJxmCbS5vzGwBI6Fpic831Dm
	JJXmNBwr1dLNr7xeItG5jXbTcQpkEGbpnMw9Ul94W5OVwINpsx1nsoZwpFrZmt2j
	yyh5yFJtuECsdWonXEnb0ClcQzdMWdIbk8c6EOU9IEPTIZe9zzywdDc0sXAsY1Gr
	Qhpku+vp7H3gtTwo5TxnDXCyMpTIjiRcjmFg5uPGEjHhNFMWZ8/8QvsUQZBabEpZ
	D26MJV4qb+IG2ESMoLxXtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782826164; x=
	1782912564; bh=DmrQNTItky/UiuZPOpMv0EVeheRMp8r3GydTi1+jvvU=; b=U
	2Sz2qW1gSOPgMObKuVV2YI42GKrQhdzQzAgPWxK3W11CX5zc04Bu2KiJHyqTv3Cs
	5f/i03fSvGFvwBIFNwWqKaiUHNxn1/YGIX7xjRmTXp+EEmZY9H0B1dcUXY69bIfs
	O9YJZ8/jgQ01aMUqnJxH5OH80Msr0n6LnCQfH/SgQvn8KSyI7WemMZVPXgOjIkzG
	iafhPik9MjtUPywDw+jiDJVlc6vhl3AYR9w+EMdZUYB5FbKxbTLJ8rs4zap1Ksn+
	eq2tAsgc3jU1GeeQGPa0vjLIVZzAUFaPtVLGMnKUeZFthBWOZuzLoaCQhDuiwZiX
	LCc7xVzPhgSSa2oxZy3hw==
X-ME-Sender: <xms:s8RDanlQmxMBGZ2_V3c8hHeK2DamYOZAKm2MFxnvnrHjQXXcEl7liw>
    <xme:s8RDalrNiNzznp_KWVyn_dGzFoOfzt3hHKnKwcJdns3fYr0MmujBDyR-xnJ94KVZC
    1fgoMbAGZJUr-fMNhrQSmnCiDSNxjo6Pyy_YQMkQ-02icqDAPVOCw>
X-ME-Proxy-Cause: dmFkZTFOc8kySVJaarJn+yOM4lWnvgTo8fH8pNsiBSOy3Wlxie2uyHPLm8RU9hRXTPadfd
    VplZMh4dQE2IFFVv08Z/Mg7w7fkT9dvWYuzilA9wynMup1c5MnGCKUibzHtnIH2nk5Ezuq
    kkmM0tmoxSB2W2a5nI9lxCKY7xgQQCKbFnEUeH6wh4Uy4vR7BjSeCnQB94Cbb7iFr1L2j3
    WCsiK6SAuPxVElZ+Tn8QQm2DcbfiuPxXujVl7tC57fTWo7OE7M9HnpgVvznow7AxFXX8Rc
    //4a9WXCZmtP7MrNLuW2qWwdBwwKTUSqSqtoXW30l6qtyJOZ3ttdJ5RiOlUZYUr8YESfAj
    NjWpzaR+KfJeu3PvgOAKQ1RlrsbhFbS2S2dFNeSjtrPC+jQKE5e03zGI1HC/FPJn8XZ3Ur
    jhyhtvO3x12/TUQ4KIh16OGDaP717xQ17u9TKr5yxedFD8ChD8shLECyYMgtXFi26cA77K
    6fgkuPGjeoSd+zfJajKZvkV7/by5fAof+d7Wwu4uZ/Pyub+wplO0ecfJLwBAQrPeTz8lI/
    p6KZJcSqNLKxBz9cT1ywzMNrXo4tJjui2Vvcf1C/S9zmrM9cuTiudZgUBps2LyFDsJeIXp
    IPn0+oUPu0v5ma7acft1jGwqEA86HRXjSbmDTm5c+Vh2guohGDiYdVlXZ0iw
X-ME-Proxy: <xmx:s8RDar041n2dZ7qGLUpXpmPMmPtitS0dv6aSQGRJT8UK4e8RV0jRqg>
    <xmx:tMRDatzpMd3JIIWC1lq6rp9LQYDeNsyao8a0ougTnd9lqWhRbEOwDw>
    <xmx:tMRDakiIoyys-h98bM1FFUUnRSd7hwhTi0Iw2ATjkmFIlpGhxoFgLA>
    <xmx:tMRDaiP-8TAEkuAr6Y8KiF1O_9wlCdVRVzlofmLsMa5Fj6hkUiK2BQ>
    <xmx:tMRDaqGIMoKsG--JyKaWiJ7bODNDXUoeKFYnKM-4bhvKAaUfx8xcetEo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DCBB7182007E; Tue, 30 Jun 2026 09:29:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AzfP_w-3vYjw
Date: Tue, 30 Jun 2026 15:29:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Morton" <akpm@linux-foundation.org>,
 "SeongJae Park" <sj@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
 "Quanmin Yan" <yanquanmin1@huawei.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <0c57d639-259c-4498-9b7f-3ac46d669935@app.fastmail.com>
In-Reply-To: <20260627223405.3533412b4010b6ce658da01f@linux-foundation.org>
References: <20260611125704.3386176-1-arnd@kernel.org>
 <20260611135608.66888-1-sj@kernel.org>
 <20260627223405.3533412b4010b6ce658da01f@linux-foundation.org>
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Jun 28, 2026, at 07:34, Andrew Morton wrote:
> On Thu, 11 Jun 2026 06:56:07 -0700 SeongJae Park <sj@kernel.org> wrote:
>
>> On Thu, 11 Jun 2026 14:56:57 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>> 
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > The main thread function has recently grown to the point of
>> > exceeding stack frame size warning limits in some configurations.
>> > This is what I hit on s390 with clang and CONFIG_KASAN:
>> > 
>> > mm/damon/core.c:3440:31: error: stack frame size (1352) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
>> >  3440 | static int kdamond_fn(struct damon_ctx *ctx)
>
> Well cheers to s390 for using a nice tight stack limit.

To clarify, this is a stack limit that I use for my randconfig build
across architectures, the default limit on allmodconfig is still 2048
bytes, and s390 generally needs a little more stack than most
other architectures.

>
>> > The largest stack usage here is inside of the kdamond_tune_intervals(),
>> > so by marking that one as noinline_for_stack, the functions individually
>> > stay below the warning limit, though kdamond_fn() itself still uses
>> > hundreds of kilobytes for some reason.
>
> Wait what wut.  This cannot mean that kdamond_fn() uses x00,000 bytes of
> stack, so what does it mean?

bytes, not kilobytes, sorry for the typo!

>> Should we add Fixes: and Cc: stable@ too?  This function was introduced by
>> commit f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning") which
>> was merged into 6.15.
>
> I don't think so - kernel is full of these offenders and it will be a
> long and painstaking process to weed them out.

I'm mainly pushing back on regressions when they happen. In my test
tree, I have a patch that adds a few bytes for Kconfig options that
cause particularly large stack frames (CONFIG_KASAN_STACK,
CONFIG_KASAN, CONFIG_64BIT, CONFIG_UBSAN_ALIGNMENT) but otherwise
use the traditional 1024 byte limit, and I send patches when I
run into any function that uses more. I have never managed to
get my backlog small enough to actually send the patch that
changes the default limits.

Right now I have

5bd54760fba1 [SUBMITTED 20260622] drm/amd/display: kunit: move dc_link objects off stack
262678481abf [SUBMITTED 20260618] usb: ucsi: huawei_gaokun: move typec_altmode off stack
2cb955c0b224 [SUBMITTED 20260618] media: v4l2-tpg: reduce stack usage for kasan builds
dfdc80171d8d [SUBMITTED 20260612] mlx5: avoid frame overflow warning
e252ac86b090 [SUBMITTED 20260611] drm/amd/display: avoid large stack allocation in 
97582da9074d [SUBMITTED 20260611] [wireless-next] wifi: mac80211: allocate backup ieee80211_nan_sched_cfg off stack
2f707af98b86 [SUBMITTED 20260611] mm/damon/core: reduce kernel stack usage
9fe35d5f1de6 [SUBMITTED 20260526] zstd: reducing inlining for KASAN_STACK
82daa7698bbe [SUBMITTED 20260520] fat: avoid stack overflow warning
dd7d4b16c1d0 [SUBMITTED 20260515] bpf: test_run: reduce kernel stack usage
75b3f86afb91 [SUBMITTED 20260515] irqchip/ast2700-intc: reduce stack usage in kunit tests
c5d5e99dfe31 [SUBMITTED 20250620] perf/arm-cmn: reduce stack usage in arm_cmn_probe()
80587b5964a1 [SUBMITTED 20250620] coredump: reduce stack usage in vfs_coredump()
89e40670333d [SUBMITTED 20250620] lib/tests: split randstruct initializer tests
723381a3739f [SUBMITTED 20250620] binfmt_elf: reduce stackusage in kunit test
9f7e36aa0b81 [SUBMITTED 20250620] [RFC] net/mlx5: don't build with CONFIG_CPUMASK_OFFSTACK
7a5ea46be400 [SUBMITTED 20250620] coresight: fix building with CONFIG_CPUMASK_OFFSTACK
40398f198b2b [SUBMITTED 20250610] drm/radeon: reduce stack frame size for radeon_cs_ioctl
b52879e6b419 [SUBMITTED 20250221] ntb: reduce stack usage in idt_scan_mws

and some patches that I have never sent so far. This is clearly an
uphill battle, but kernel stack overflows are a real and build testing
with a reasonably small limit is only one line of defense against these.

     Arnd
