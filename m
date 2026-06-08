Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820F30DED0
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884841; cv=none; b=PoS5Rrc27rTLY6U7hQOkZ9DqcyQO8uWcPArZIZVfiXB4Hi8+jpwArFFOvFGu184yaUO7/cgg5k184M6OnBJFIXGRP0ztZJrP+9lzBqM/yuRNMdTWhWsuTkjdfIcnL706XtFbpGnPzcZ4RTkT9lD/q77ChimDlYqKSig4OJH6y9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884841; c=relaxed/simple;
	bh=ye/7h8vRT/vmH/8DPzh8vp+7gQ/40g53kFNbXSkrZko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDtjSOsQFv+pkgBrFD5ROxsHJNKBZYRxx+W5IFlccqHJzhLnC/GHSlSdXMe91PdEaDxyg4ljyy/YApnCukLA2VNBqgAQAUXl1XL+IsFfbS+UL/NyIyYBEXF3kPYFWeeoB03MmyEzo+8QgWecpB1PTv/NhY7zJBK5vHAmzpSJPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrABnSQ4gJSZqtFcXAA--.60942S2;
	Mon, 08 Jun 2026 10:12:48 +0800 (CST)
Received: from [10.12.169.28] (unknown [10.12.169.28])
	by gateway (Coremail) with SMTP id _____wCHgAcXJSZqS16oAQ--.47447S2;
	Mon, 08 Jun 2026 10:12:39 +0800 (CST)
Message-ID: <20bde227-fe15-42f2-bc83-51801e1f795d@hust.edu.cn>
Date: Mon, 8 Jun 2026 10:12:39 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] docs/zh: update DAMON usage sysfs documentation
To: Doehyun Baek <doehyunbaek@gmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 SeongJae Park <sj@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20260523094420.741003-1-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABnSQ4gJSZqtFcXAA--.60942S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8CFy5Xw15Kr17Gw4fGrg_yoW5Xryfp3
	Z8CFyIqa13t343Xr13J34UZa1fJFWfJ3yYgF9Fqwn5JF1vqa4kK3WUKryagFyqvrySqFy5
	AFZ8t34xG3W7urJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


On 5/23/26 5:44 PM, Doehyun Baek wrote:
> Hi,
>
> The Simplified and Traditional Chinese DAMON usage translations are
> missing selected updates that are already documented in the English file.
> As a result, parts of the translated sysfs hierarchy and descriptions are
> stale, and the translations also lack the newer introduction of DAMON's
> special-purpose modules.

Hi Doehyun,

Thanks for your patch. To track the translation status of the 
documentation in different locales, we define a uniform format in 
how-to.rst [1]. Please revise the commit message of two patches.

	docs/zh_CN: Add/Update self-protection index Chinese translation

	Translate .../security/self-protection.rst into Chinese.

	Update the translation through commit b080e52110ea
	("docs: update self-protection __ro_after_init status")
	# 请执行 git log --oneline <您翻译的英文文档路径>，并替换上述内容

	Signed-off-by: Yanteng Si <si.yanteng@linux.dev>
	# 如果您前面的步骤正确执行，该行会自动显示，否则请检查 gitconfig 文件

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/translations/zh_CN/how-to.rst#n252

>
> The gaps correspond to the following English documentation commits:
>
>    commit a7bb1e754559 ("Docs/admin-guide/mm/damon/usage: document 'nid' file")
>    commit e85e965bdbec ("Docs/admin-guide/mm/damon/usage: document refresh_ms file")
>    commit e0c725455fd5 ("Docs/admin-guide/mm/damon/usage: document addr_unit file")
>    commit e06469cdf1fd ("Docs/admin-guide/mm/damon/usage: document obsolete_target file")
>    commit 2584dd7496c5 ("Docs/admin-guide/mm/damon/usage: update for max_nr_snapshots")
>    commit 652fd06d20da ("Docs/admin-guide/mm/damon/usage: update stats update process for refresh_ms")
>    commit e7df7a0bfc90 ("Docs/admin-guide/mm/damon/usage: introduce DAMON modules at the beginning")
>    commit d9cfe515d36e ("Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file")
>

> Update both translations only for those stale DAMON usage entries,
> including refresh_ms, addr_unit, obsolete_target, goal_tuner, nid, and
> max_nr_snapshots.
>
> Doehyun Baek (2):
>    docs/zh_CN: update DAMON usage sysfs documentation
>    docs/zh_TW: update DAMON usage sysfs documentation
>
>   .../zh_CN/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
>   .../zh_TW/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
>   2 files changed, 80 insertions(+), 32 deletions(-)
>
>
> base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5

