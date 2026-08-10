Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8525B0A3
	for <damon@lists.linux.dev>; Mon, 10 Aug 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340506; cv=none; b=KdIhkkQqWHZC9hmm5YDGB//0/+Hr99oQ3uojuUOsBMgqKR6+SM1uD4cVbfivwFs2VsPPadJWTfnQ7Z/+0a2Hkbkb1lB1lXlm8sdxAjaCttm2cJ/pbwthyJTl8yLNMczx/ijm364R+P+0Xs2cAKA5CjbqxnM+7yzJpfNZLk3mDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340506; c=relaxed/simple;
	bh=yuwRhS3IGJ2XohwKeGOu32Y9La6lsNbBcmsGCEpNq+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgRWQ5dP7MPsoZJRDNfIuR9d9ULslQkl2za9YMeHR/aGUWuMMz9pjXnUCHZT0SJtqf8H6PGl+DKmzL1j/bI3kLi4P0i1kAq0S/ZpfI4FOQz/JPBXTHj8hqieIo8LbJW/t34DAuAY/oC5aU0ofrCyVxlPB8Yim8Yxff0+9z4dkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAAX7qJZZHlqoXozAw--.17523S2;
	Mon, 10 Aug 2026 13:40:41 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wB3QlZYZHlqpkA1AA--.42332S2;
	Mon, 10 Aug 2026 13:40:41 +0800 (CST)
Message-ID: <f14f7349-a827-4bc9-904c-13fe5c6e6412@hust.edu.cn>
Date: Mon, 10 Aug 2026 13:40:40 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] docs/zh_CN: update DAMON translations
To: Doehyun Baek <doehyunbaek@gmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>
Cc: SJ Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708073246.1652828-1-doehyunbaek@gmail.com>
 <CAN-j9UpTxLzvu7EruQW+kvvxivrtOaS3FBW_8dLc9TWuvLO7nA@mail.gmail.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <CAN-j9UpTxLzvu7EruQW+kvvxivrtOaS3FBW_8dLc9TWuvLO7nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrAAX7qJZZHlqoXozAw--.17523S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOp7k0a2IF6F4UM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCF54CYxVAaw2AFwI0_Jrv_JF1l4c8EcI0Ec7CjxVAaw2AF
	wI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsrWFUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 8/10/26 1:14 PM, Doehyun Baek wrote:
> Hi all,
>
> A gentle ping on this series. It is still awaiting review.
>
> If the current scope is too broad, I can split the series or reduce 
> its scope.
> Conversely, I can expand it to cover additional DAMON documentation if 
> that would be preferable.


This scope is actually a little broad, but still fine. The real problem 
is, this patch series is not in my todo list.

Now it is, and I will post my review quickly.

Dongliang Mu


>
> Please let me know how you would like me to proceed.
>
> Thanks,
> Doehyun

