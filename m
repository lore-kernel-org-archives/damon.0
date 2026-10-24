Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792805147;
	b=vHxDoXprC2BAGryXq/0ceQRo+FKkjn4FzaAJnHMll3ptSIXFiwsj8oXk5aB67InKSnKs
	 DV123PjzQPFDj7ChcMU+7TgRrvf+TXUy0aCEpuadqZYoLCFrRHrFZW2+rX3FHg/QCb0/t
	 JMAabgXzJ0lSTnN4tP633044tFxE3n8IIxSb88Xau1bjsZb/fk8ikthzk1EMup/mi1JAz
	 0tgPdefNEghebix3zsSU2uj06lu9H5PY7zop6q5sR2VtfPUFTRLwpbNsV0ACqEqTvQMbp
	 D05Ig+NVeiA6KPTqR63e4c4Wq4TL60xcjet85JjL833g4Kvrc3/jSuO/DkZyqpT/XIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792805147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wbjDH2XGRGAyB1Jgh8Mq6npQkQrEQtHcwNp3x4kkvmY=;
	b=WaeY2cTFwgaxThlzoaEqw0mV0idSOnmP3LmbH0ZuBpdApQk9EksNHmqHS/WWczd9m1j8
	 0US1uoO6CXiig3jbZm/m8A57hLTqfAKBeYrdV+WZ4dhM40NlM9ud5pvXfRjhG1gRmh1q+
	 mJdpVcsSK9wqA4mIXKt5dS27WmecqHfeZaZdgsNidwQ2BSZZbeSeBCfTou9eleKLvDFNT
	 QrBEjBgWONosO/t9S+cN35WHaN7C39IvUCLyaMOPKTeQXLej0tQBvTcTsoeOBT0fw/MUk
	 nJyVZ7JNgKSWN6pM3TXL6tF4wNX8OuajBuybUvMicMhycpbE/iQMD5zpVwm2Qq1I8zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nFJ/Q0Zg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB6606A31A;
	Sat, 24 Oct 2026 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFJ/Q0Zg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA11F01825;
	Sat, 24 Oct 2026 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792805147;
	bh=wbjDH2XGRGAyB1Jgh8Mq6npQkQrEQtHcwNp3x4kkvmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFJ/Q0ZgIzG50WO/AI1/5yODoNQj7ueXInuMSDgVRCkvcZuqgZyA+wItoQ+lRHXid
	 3ZbWaTENm+BgSkvdsFyXdhu1QvyUsNNYcu3lpNBnR7fGH1p20yKHKo/PsDi8eGAfuf
	 rvQ9qJ2a6MFod7iy42qyBxhTnwHW3deIUxQFTYcgFBlo53xiwUv64EH5fF++rRIBUm
	 zmkf6b3FK+R5D2uJ+pfO0nqXewuq3OU0rK76J1cIBqvrXfjUBp54kL0Lk85gS4tAEf
	 64M6g5UaEFIvLzlCOBx1Xqm+YI2WF7q8gnR7VnRrIPew2Hz2g85yrxEY3NjbR4KsEA
	 AKbZva0DwYzaQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH] mm/damon: align MMU notifier range when clearing PMD young bit
Date: Fri, 23 Oct 2026 18:25:39 -0700
Message-ID: <20261024012540.89397-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <179273169185.2.1655708299473876346.damon-pmd-kvm-reply-draft@gmail.com>
References: 
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

On Fri, 23 Oct 2026 13:01:31 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Thu, 22 Oct 2026 17:20:17 -0700 SJ Park <sj@kernel.org> wrote:
> > I Cc-ed them.  Please Cc all
> > recipients who get_maitnainer.pl is recommending, from the next time.
> 
> Sorry for that. Maybe I will use b4 next time :)
> 
> > However, I think this patch explains its context very well, and therefore
> > this link is not needed.
> 
> Sure , That make sense.
> 
> > Were you also able to confirm the expected wrong behavior (missing part
> > of the sampled huge page and age secondary mapping), too?
> 
> Yes. A test with nested x86-64 KVM confirmed both effects. With
> 4 KiB EPT mappings, a midpoint PMD sample left the first 1 MiB young and
> aged the next THP's first 1 MiB. With 2 MiB EPT mappings, both whole THPs
> were aged. After the fix, only the sampled THP was aged in both cases.

Thank you for confirming!


Thanks,
SJ

[...]
