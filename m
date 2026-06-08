Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15532B11D
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901927; cv=none; b=GbXhtB7kQpIHiclK7NifiyfdFDSRmUIvZ0g5oWWvJm7w9j86oexHVxF6usEQ/RZoVDxuUxB3XRen3N06oFKs3AR7jGxhaGG+N3E6/OxUg1nrfmgGkPAcnTfhsm2FG35yyRTBdjrO+6Kb3jyzpwWUFtsfcV5i4JzhJGN7PLxZyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901927; c=relaxed/simple;
	bh=4j2NsQcX3l+LMH7OnGZvlcFy69ikfwcYFnc4uco+C4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ7jtnjNf2ynZ7HOveHgNG76TyJX0Obx8aXNEhNGMl4rbeRpSyw5I13urwCJxtdpabsCXGK6WGxwhWDglwcsuRRZrLT/7R0W8voLQ4LtoTLiPhU+F2MAa8LKleYM1mC1PeIDBK/8JIyr5oGJ4ghV2Cbdj9ubiRT4fDNdLWN6FDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrACnp6D7ZyZq9vNnAA--.31570S2;
	Mon, 08 Jun 2026 14:58:03 +0800 (CST)
Received: from [10.12.169.28] (unknown [10.12.169.28])
	by gateway (Coremail) with SMTP id _____wB3fwv4ZyZqW+QyAA--.62654S2;
	Mon, 08 Jun 2026 14:58:01 +0800 (CST)
Message-ID: <150c4c64-f3fb-439f-b15f-e04cab3d232f@hust.edu.cn>
Date: Mon, 8 Jun 2026 14:58:00 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] docs/zh: update DAMON usage sysfs documentation
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 SeongJae Park <sj@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
 Hu Haowen <2023002089@link.tyut.edu.cn>
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
 <20260608060302.1564003-1-doehyunbaek@gmail.com>
 <CAN-j9UrkjjrO-1fs9Q4_HQMTM5Gj1qjyNLF5F1JG+Wzimd5naw@mail.gmail.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <CAN-j9UrkjjrO-1fs9Q4_HQMTM5Gj1qjyNLF5F1JG+Wzimd5naw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACnp6D7ZyZq9vNnAA--.31570S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykXry3Gr48CF4fGF4rXwb_yoWDtFg_Zr
	W8ZFy7Z3yYqas8JFWkKrnxCrWDuF40qws8Za4Dt3yUArs0qa1DAr1kW39Y934xXr4kAFZx
	Crn0qa1furnxujkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbm8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/8/26 2:05 PM, Doehyun Baek wrote:
> Hi, thanks for your kind reply.
>
> Sorry for not following the how-to.rst. I should have taken more care.
>
> I updated the commit messages and sent v2 patches.

Thanks for your quick feedback. But please keep a rule in mind - Do not 
top-posting in the LKML.

I will review patch v2 ASAP.

Dongliang Mu

>
> Best,
>
> On Mon, Jun 8, 2026 at 8:03 AM Doehyun Baek <doehyunbaek@gmail.com> wrote:
>
>     Changes since v1:
>     - Revise both commit messages to follow the translation update format
>       documented in Documentation/translations/zh_CN/how-to.rst.
>
>     Doehyun Baek (2):
>       docs/zh_CN: update DAMON usage Chinese translation
>       docs/zh_TW: update DAMON usage Traditional Chinese translation
>
>      .../zh_CN/admin-guide/mm/damon/usage.rst      | 56
>     +++++++++++++------
>      .../zh_TW/admin-guide/mm/damon/usage.rst      | 56
>     +++++++++++++------
>      2 files changed, 80 insertions(+), 32 deletions(-)
>
>
>     base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
>     -- 
>     2.43.0
>
>
>
> -- 
> Doehyun Baek

