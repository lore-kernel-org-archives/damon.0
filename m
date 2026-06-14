Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714F2C2349;
	Sun, 14 Jun 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458867; cv=none; b=dP5edPOuVP0bc+5s1npy6tQB77uiB7MS5E4dRhW1bjvVZcbr5Iu4YjSxWqLqL9ucoyeJ9wJ4+LUEhyxNTT3JsfPBMxra9OgspNOqTz65TptbivIR6rGsKwCQ26qUAey8LRDcFVSeONsZ7mJS4ma3Oozd62RNCkujk7wybVPsqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458867; c=relaxed/simple;
	bh=cWoRYqnYZDdmGorHMWMFuYIp6Jrf+u9bzVkAOHduOvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq24ZTJggSvKBwoNdnoVmAGTs3YvawM+dmBlT5bxyj2qCkkYfyAFiRo69yW8pbyBJ2YdcAoYma+ZBCuHpNbzWLnXP7/dAuXFnDRbfvi/ZBtVcAArWaaIFEpd+EFWLGOIp88gIWQaPvO0mrDHYWOwOsCD8gbKEHB2z3tV/MVZLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eJgqORMP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJgqORMP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/lr61Re4zzXuc18olAn0JXzQGr2/Vz7uupbDe/VKrqY=; b=eJgqORMPfc8OPCSx7stKzPrFO2
	6KTPvIA3p9TWpW6Er/bQKutNqPA3wYzdmET3BkJiSD5H0PgnMuXT3kVpopJwnJ9EjQ5MLQGIHYpoC
	/NB6Z0owrWnpUChG9YP+Xta+TPOzkg9/s9MEB133vyLeAid4H2+mXZyJ5K3lFwSkVU5OuPS03ztnC
	SgPTzEefS0I7iO77N4s2tTZwWhQSPHZYfzvq2yahfJlNPQ8oKSgbW9wp/sBwLk/pGgmB5KitrNH+e
	oAP+/uY7AnzhP8aE+tJTyMvEkLXS1seuy30L0t5299MuqATilbV0NGTpZ7xJHW+tMirNo6VmMLP9X
	3dQ/7rKA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYopV-0000000DDS2-3V67;
	Sun, 14 Jun 2026 17:41:05 +0000
Message-ID: <4df95955-b255-4e5a-90c4-35db02f3111f@infradead.org>
Date: Sun, 14 Jun 2026 10:41:05 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jun 11 (damon)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>, SeongJae Park <sj@kernel.org>,
 damon@lists.linux.dev
References: <airHKHVILKSiKTVM@sirena.co.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <airHKHVILKSiKTVM@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/11/26 7:33 AM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260610:
> 

Please add missing kernel-doc comments:

WARNING: ../include/linux/damon.h:909 struct member 'probes' not described in 'damon_ctx'
WARNING: ../include/linux/damon.h:909 struct member 'rnd_state' not described in 'damon_ctx'

thanks.
-- 
~Randy

