Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5719D8BC
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054161; cv=none; b=CrurGg0f2UH/NYPMHWBbht75xvCZ9iaJWVKAvkSRbP2o8mYhDjW9PIb/P8tzusolfsG566bsv5FALLuaQoBJSCPwXvD1jAwabyUo93qfd9Kb433JI/Ex9OSZGfD9ITkJc2zASjPQcK7B7yy7irZALKvsVxXeumqLKrR0TJw9i6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054161; c=relaxed/simple;
	bh=zpyxIg705ZEXILEn0+/H6dTAHt6pC3npBae7gsmy1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrIhPe9bZuLt1g6WKc4jFI3mNjMkTkMBN6rkEXBpIDNe5XsuHC4eOXGHpe0Wpi8jFlyt0TpPXf/no3U6nX2Wm77cxTioVyRA4qPihEsyZOWuRxpOxmMp7QbaUJrv06Qe7dfY3uMGKBLdu0oJn4G4ezCHqmx4Lf43XMHDkXaPeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAB3_zXFuihqVtobAA--.32693S2;
	Wed, 10 Jun 2026 09:15:49 +0800 (CST)
Received: from [10.11.71.25] (unknown [10.11.71.25])
	by gateway (Coremail) with SMTP id _____wCnrwvBuihqaaU7AA--.2041S2;
	Wed, 10 Jun 2026 09:15:46 +0800 (CST)
Message-ID: <d2a6a7f1-96e1-4e6b-abfb-e9b13dff3561@hust.edu.cn>
Date: Wed, 10 Jun 2026 09:15:45 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] docs/mm/damon: fix docs and update zh_CN
To: SeongJae Park <sj@kernel.org>, Doehyun Baek <doehyunbaek@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
 Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
References: <20260609235556.73472-1-sj@kernel.org>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20260609235556.73472-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3_zXFuihqVtobAA--.32693S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DGw4DtF4kJF4xuw15Arb_yoW8Ar1Upa
	yrKF4aka1DAFyvyr1xK3y8Zr1kG3sxGrW8Gas8JasrJF1YqFySgFyFyayYvFyDZr95Gay2
	qw1UKFn7Ja1UAFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jy38nUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/10/26 7:55 AM, SeongJae Park wrote:
> Hello Doehyun,
>
> On Tue,  9 Jun 2026 14:34:24 +0000 Doehyun Baek <doehyunbaek@gmail.com> wrote:
>
>> First of all, thank you very much, Dongliang, for your time and
>> dedication in reviewing the previous versions.
>>
>> This v4 sends the original English DAMON documentation fixes as the
>> first patch, and the Simplified Chinese translation update as the
>> second patch.

Hi Doehyun,

I think my earlier message may have been unclear, so I’d like to clarify 
the points below.

First, as suggested by SeongJae Park, please submit a standalone patch 
to the |mm-new| or |linux-doc| tree to correct these typos.

Once this typo-fix patch is merged, you may proceed to submit the 
Chinese translation patches.

Additionally, please split patch 2/2 into two separate patches, with 
each patch covering changes to only one file.

Dongliang Mu

>>
>> For zh_CN, I translated the current DAMON usage.rst paragraph by
>> paragraph, and added missing pieces such as stat.rst and the related
>> index/design references.  The zh_TW changes from earlier versions are
>> dropped from this series.
> Thank you for sharing this patch series!  However, to my understanding, the
> path to the mainline for English documents and Chinese documents are different.
> Sending patches for English document and Chinese document as one series is
> therefore making it complicated, in my opinion.  Could you please rebase
> English document part to mm-new [1] and send as a separate patch?


Totally agree. Please follow this suggestion.


>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
>
>
> Thanks,
> SJ
>
> [...]

