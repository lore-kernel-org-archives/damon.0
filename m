Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281836;
	b=PE9wypxa8d85d5zsl1ZfDCagPZiMauU0zECaaO/ns2Tt1noiH3XQw+LRHvTIiZjEoTSH
	 ATZj+iphN4OxgM6kpoYxbrUPo0L2GbMmDTjCtzlklzPWlQwJCZ3v7uWCYzQ1xsJOExMf9
	 /IKxdIEb2aCFTB6lxP+Wnh7zA8NKXaTNS+/iH58PhmZrSMJbUMLTKGMMUbyKpaUiHw1+5
	 BVykOaqdiZpciNBIY2buQcv0XJlGkpOq1fYvK2GbksTbp5jncPERHDslBt4ZVXaOhnpfx
	 SRrFiK7WlaFGS0ei/0u+9NDGnUDOJH+YuWzW+gAxVmxXAn9OpXOlJIKKScdLBjdBRUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fUMUx3jV+Cza+EQigl1rcYAIkS0QbtIwp0tnJ+ZrKLk=;
	b=5LtLvxs+7hpG0JHLoF56XhtRXKET68j3Yb1+GRaR5+rSLXsvAA535NvY+tm903LPGpoc
	 tRvuGoiwGbVuoVV6uCXxWSqnsEr7qyRSrH1xX8dc9zodo7Wq7spRySvd97b93P0KzAgKt
	 bvB07jszOz2aGBnppl0Cax6tx90mu6v0AiH+a5WrB41NjsXYPHMSCWQTZWkfXIQZax/05
	 cR/WrXmTbV2hkZJdPAwBKwfpx0azL8rdQjMCS1w58d4qZVVe2UtKf5kZhOOZacqG7/Zuw
	 ZEfnJpoz1N13HUjaQuiYMasl0me7XmZ7c1qpdCBYh9UGxP7LFXGY5fkHFM+a/EY329w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqhNilQt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C93606A33D;
	Sat, 21 Nov 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqhNilQt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20501F000C0;
	Sat, 21 Nov 2026 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795281836;
	bh=fUMUx3jV+Cza+EQigl1rcYAIkS0QbtIwp0tnJ+ZrKLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqhNilQtZwoham26ThtkeeHFtRSps35xLwa1G2F5usdzpdsiI6le/VhPeXYv1dufh
	 OgjnWpU9RRjsrB0eA7/vhOqPTprsZS6b8J45b7hr5KwnQE3bHQKEkFd6V1O+ucl6f1
	 NiZBhQ5VDsvThE9AzIuNjg9TcJQPe6e2fGOV6BdxqJ5UrI11oSpbUH+qXoLw940UkO
	 GABVMs95EFUbN0PV6MrjJecVWDRwRDL5tLSbcZWSyG6jzK3h4Gen5q0cZ9AgCF0sLD
	 T9nD7cd/T3xXNxdyUHmH8nGpteEU5wZX5UuqUZTGXQ/Up7i/WAZqKgpOnPJiXT3ZCO
	 W5ZrEdrbWrXvw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	arijit.desaii@crusoe.ai,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH 2/4] mm/damon/reclaim: set memory PSI 0.05% as default quota goal
Date: Sat, 21 Nov 2026 09:23:47 -0800
Message-ID: <20261121172348.80312-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179526475633.4.14859465649138957731.b4-reply@b4>
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

Hi Aveline,

On Sat, 21 Nov 2026 23:39:16 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Thu, 19 Nov 2026 22:07:36 -0800 SJ Park wrote:
> 
> > Set 0.5 milliseconds per second
> > (0.5%) as the default auto-tuning target memory pressure ratio.
> 
> 0.5 ms per second comes out to 0.05%.
> 
> > +static unsigned long quota_mem_pressure_us __read_mostly = 500;
> 
> With a fixed 500 us target, maybe a longer aggregation interval also
> lengthen the PSI measurement window. For example, if the quota ends up
> being reset every 2 s, should 1000 us of stalls still be compared 
> against 500 us? If so, the tuner would drop the effective quota
> to 1 byte, skipping pageout for the next quota window.

DAMOS quota is not reset for aggregation interval.  It has a separate interval
for quota reset.  It is exposed to users via quotqa_reset_interval_ms
parameter.  The default value is 1 second.

The quota reset interval is evaluated for every sampling interval, though.  If
the sampling interval is tuned to be larger than 1 second, the problem Aveline
mentioned could happen.

But, I'm not sure if it could be a real problem.  Reclaiming more than expected
is a definite problem that can degrade the system performance.  Reclaiming less
than expected is less concerning, as long as the extent is not too much.  It
doesn't regress something.  Anyway this is a best effort proactive reclamation.

We could revisit this if it becomes clear some real users find it as a problem.


Thanks,
SJ

[...]
