Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE12472A2;
	Sun, 14 Jun 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463809; cv=none; b=LHdo1VgWT885vLsNS8HEk0mNZ7udBI4CvCLN7VR+PNpGinPy5iVtjy6aqvLUu7G8slo2JzxErNhTMSy4tv9mA3YufOZ85wlAeWMaC2JWDrq8wl1ywRD2DkbJErtQFOe0TBNpWoGqc3nSt/U7+4x9ImM6MgnDeLEYM+X9n1J+tLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463809; c=relaxed/simple;
	bh=VzcB63AsSNF7wmll/zmjtwwlGjqerrbUFdIv1sQDCaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN68ZZQAUsrRgebrBSVXV85lsetrXDnvWG++wBVNtABlTEvlUIh6+IVoCPuHeb12EYNbjHADg2RyDsXpV/K4mhh5SXFkv1WJbiOpg7EAEJXVlDX4OPbZy0KNhUcsVNZJrdi8SiUyVM0V5hDr9s3pqPFdxrdMKtgZ3TkUZWLN59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z5ujfX3x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z5ujfX3x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PiLz037c9nzz/qf1xpC6xtNQEmyk3VTIoDteshTl2pc=; b=z5ujfX3xsDZM98LknmDlWovFa4
	ajtINxr9poE3cPXQamjpV/NKJ4sfB4lAVoOyehqEvCMHezwGD/Q/6Mxi0ka5psM2caBGYtXoPJBi+
	lifs80vBP5Z61KX39tPSxhZhzDv+DLzZlJ/JujBeQWWObuT1Abb4jDkluDIoa2uCsfjMbhdvfKTq2
	4dbuO34dtjlCyf/tt8sP23K9uN9/+ZF6tDidpLUQfgrHnGpGX34UmyRp9YrENys9V2g37RsxEFKD+
	E90iVTf/Z6kBi7ncFIUvEeTYm1Mu23a5SdJ4V8oVq10kL/7ygSOWWFyVsm4c99CmugzSscqZ6DpS0
	eP+vuNSA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYq7A-0000000DFWE-1KEn;
	Sun, 14 Jun 2026 19:03:24 +0000
Message-ID: <13b452d2-d81c-4686-a94f-3789e92b4a47@infradead.org>
Date: Sun, 14 Jun 2026 12:03:23 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jun 11 (damon)
To: SeongJae Park <sj@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Jiayuan Chen <jiayuan.chen@shopee.com>, damon@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260614184235.101552-1-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260614184235.101552-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/26 11:42 AM, SeongJae Park wrote:
> Hello Randy,
> 
> On Sun, 14 Jun 2026 10:41:05 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
>>
>> On 6/11/26 7:33 AM, Mark Brown wrote:
>>> Hi all,
>>>
>>> Changes since 20260610:
>>>
>>
>> Please add missing kernel-doc comments:
>>
>> WARNING: ../include/linux/damon.h:909 struct member 'probes' not described in 'damon_ctx'
>> WARNING: ../include/linux/damon.h:909 struct member 'rnd_state' not described in 'damon_ctx'
> 
> Thank you for notifying this!
> 
> The fixes should be trivial.  I made those and queued [1,2] on damon/next tree.
> DAMON patches are merged into next tree via mm.git.  And mm.git is currently
> closed for non-urgent issues to focus on making things for next merge window
> stabilized.  I will therefore post the fixes after the next merge window is
> closed (7.2-rc1 release).
> 
> Please let me know if I'm missing something or you have any different opinion.
> 
> [1] https://git.kernel.org/sj/c/892a69e2774fcface1202dbdc2ff62e433f487fa
> [2] https://git.kernel.org/sj/c/b205766e8d676b9c9e3af828e736215bc54f4690

LGTM. Thanks.

-- 
~Randy

