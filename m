Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378990;
	b=PlHl94VacOfWwm3CthMZXZy2jvxY0gEt43GEGpVjNK5pw4boqGcziIZ1V9AkWwZ+Q7Yl
	 4rNq4LnLh7yda6L+H5g7xIPpcrNJetAhTJMNwVexXzAi+8wPFt0ll1PftTSScoot7H6p/
	 t5ECEe4vpAIxtvY3kj/UXx73OIfY1I7dgk5GWKbbIZyV/ENUBLL7Ur0K/oHTDFQYNGl27
	 +0Wp9dEnhc6x9p51h4P6LkYjDrq8gTdHcN5ETszX+75JfXVl5Ydmpm7qFWaICPVRullIl
	 sh3vlOQBn/5wmMAIxkKnT1tYiO9NziPTkSsI0x/b1sGRq5q+8Jp57KSEFee4NaADimQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ie3mh91Y4PxnFzZQ4NkpPcqbOA7zUvMeHhYs25z4a0=;
	b=eItdjIvkM1rpQaxSvGLbJmkcAYmVgHDKRNVRO3Knv++rsHSa91DrmKnWy7QP0nXzeEfb
	 cF7CuYLx5zyaaDyXq/qIIxurx94t/C30GvWEjWso7NfUapIbIlJsUBIeWJGBVkk2FOsMG
	 TuXeWZkK42gPb9kMCRf7cbMD15dtWmgBqVueyACF9MWQb6Tmf+ciyQpIxOS71dw4JqzzM
	 8AAiSe7/6XarJKN0xANsTAKCx+6l4/PUQw8lnZ/WkewW4DogmAvauKc5o9BAQzYDFB9e1
	 AMiFey1ML9Gvc8tEcRUr0GLDaMljQ45Hwd4kR2/nF2OCtzMO3QLph+Oi+GGD/MyKEqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aR5tLEBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC76606A31A;
	Sun, 22 Nov 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aR5tLEBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDCE1F000C0;
	Sun, 22 Nov 2026 20:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378990;
	bh=5ie3mh91Y4PxnFzZQ4NkpPcqbOA7zUvMeHhYs25z4a0=;
	h=From:To:Cc:Subject:Date;
	b=aR5tLEBiQQ9qYhBlbQ58FE48NPpxIOIUpGWIAD02M7RR45W6n5k+DccC9MWIJ2Nmx
	 dwjYxAoyhRkFAtxbkIfUGEHmMdFDpqFgqdupeb/2hLSojI+rEaPKd/2/GoXtYEzVoX
	 fo5PX1hSj4+/fb57vEVq9MsQ4TGdn+1sLTrfE0BIJrD1krSnQGLeYS+UTR987NuAiw
	 r5tAQX8ugV+IFEAnPmLQeUfpe3UgpX8YcviU55XA7Gzms9R1qof+T7avoeYgVkd2M4
	 QRLHHPo3R4VDTZiIOVCmAbgUkRmm9G8f6maAD62f7EmIGJ54ZP7SbheZa6ZAMMxq0J
	 kzmZ2/LeGwH0A==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Wrong example command for auto-tuned DAMON-based proactive reclamation, and solution/workarounds
Date: Sun, 22 Nov 2026 12:22:57 -0800
Message-ID: <20261122202258.161562-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Hello community,


I suggested wrong way to utilize DAMON for auto-tuned proactive reclamation.
Let me explain more details and correct way to do that.

Wrong Suggestion
================

In OSSummit Europe'26 and a few offline discussions, I suggested [1,2,3] people
to try DAMON-based auto-tuned based proactive reclamation using DAMON
user-space tool (damo) [4] like below:

    $ sudo ./damo start --monitoring_intervals_autotune \
            --damos_action pageout --damos_access_rate 0% 0% \
            --damos_age 2m max \
            --damos_quota_space 128M --damos_quota_interval 1s \
            --damos_quota_goal some_mem_psi_us 5000

I found [5] it will reclaim much less than expected amount of memory.  That's
due to the mixed use of '--damos_age' and '--monitoring_intervals_autotune'.
The intention is to reclaim regions that not accessed for two or more minutes,
while auto-tuning DAMON internal for optimum access monitoring.  But, in this
setup, the coldness threshold (2 minutes) can increase up to 4,000 minutes.
Memory that unaccessed for 4,000 or more would be rare, even in real workloads.
That's why it is expectd to reclaim less than expected amount of memory.
Please read the issue finding [5] mail for more details.

So sorry for the confusion.

Corrected Suggestion
====================

A right approach to utilize DAMON for auto-tuned proactive reclamation would be
using 'age_ms' DAMOS fitler [6] instead of the age threshold (--damos_age).  It
could be done using DAMON user-sapce tool (damo), like below.

    $ sudo ./damo start --monitoring_intervals_autotune \
            --damos_action pageout --damos_access_rate 0% 0% \
            --damos_filter allow age_ms age 2m max \
            --damos_quota_space 128M --damos_quota_interval 1s \
            --damos_quota_goal some_mem_psi_us 5000

Note that age_ms DAMOS filter is not yet landed on the mainline Linux kernel.
It is expected to be landed on Linux v7.5.  DAMON user-space tool (damo) also
got the support of it starting from v3.4.4.

Using the version of damo, you can also show if your kernel supports age_ms
DAMOS filter or not, like below:

    $ sudo ./damo report sysinfo --print_feature_name_only \
            --print unavailable_features | grep "sysfs/damos_filter_age_ms"

If the command shows nothing, your kernel supports age_ms DAMOS filter.

If you want to try this by backporting the feature on your kernel and need
help, please feel free to reach out.

Workaround 1: Periodic age threshold update
===========================================

In some cases you might unable to use the age_ms DAMOS filter.  As I also
shared on the problem sharing mail [4], you could work around by periodically
refreshing the threshold.  Using damo, you could do that like below:

    $ sudo ./damo start --monitoring_intervals_autotune \
            --damos_action pageout --damos_access_rate 0% 0% \
            --damos_age 2m max \
            --damos_quota_space 128M --damos_quota_interval 1s \
            --damos_quota_goal some_mem_psi_us 5000
    $ while :; do \
            sudo ./damo tune --monitoring_intervals_autotune \
                    --damos_action pageout --damos_access_rate 0% 0% \
                    --damos_age 2m max \
                    --damos_quota_space 128M --damos_quota_interval 1s \
                    --damos_quota_goal some_mem_psi_us 5000; \
            sleep 300; \
      done

The first command starts the auto-tuned proactive reclamation.  The second
command starts an infinite loop that adjust the effective coldness threshold
for tuned intervals every 300 seconds.

Note that DAMON user-space tool (damo) of v3.4.6 and earlier versions will not
work as intended with the above example.  Those versions will reset the
auto-tuned sampling and aggregation intervals back to the default values (5ms
and 100ms).  Hence the coldness threshold is also not properly updated.  To use
those versions, users should first see the tuned intervals and manually set
those on periodic update command.

Because that's too cumbersome, I made a change [7] that avoids such unnecessary
reset.  With the change, the above example will work.  The change will be
included to damo v3.4.7, which will be released tomorrow.

Workaround 2: Small coldness threshold
======================================

The periodic updte might also not feasible for you.  In the case, the simplest
workaround would be setting the coldness threshold to small value, like also
mentioned in the issue finding mail [5].  For example, like below.

    $ sudo ./damo start --monitoring_intervals_autotune \
            --damos_action pageout --damos_access_rate 0% 0% \
            --damos_filter allow age_ms age 300ms max \
            --damos_quota_space 128M --damos_quota_interval 1s \
            --damos_quota_goal some_mem_psi_us 5000

The effective coldness threshold can still be increased, up to 600 seconds.  In
usual real world workload, the aggregation interval would converge to 2-20
seconds.  The effective coldness threshold in the above example becomes
6-60 seconds.  It may look too small threshold.  But because it has memory
pressure based coldness threshold auto-tuning, the auto-tuned threshold would
be larger than 6-60 seconds.

Wrapup
======

Do not try the example command for auto-tuned proactive reclamation that I
suggested at OSSummit'26 and offline discussions.  Use age_ms DAMOS filter as
explained abovely.  Feel free to request porting help if needed.  If age_ms
DAMOS filter is not feasible, consider periodic threshold update and small
threshold as workarounds.

Again, sorry for the wrong example command.  And I hope the above solution and
workarounds help.  Pleae feel free to reach out for any questions and issues.

[1] OSSummit talk: https://sched.co/2RaXh
[2] OSSummit talk video: https://youtu.be/GolUxZZrVsU?si=qdPFE1RZAaNZ0lsY
[3] OSSummit talk slides: https://hosted-files.sched.co/osselceu2026/67/damon_howto.pdf?_gl=1*1dml5iu*_gcl_au*MTM5ODk2ODM5LjE3OTE1Mzg3NDA.*FPAU*MTM5ODk2ODM5LjE3OTE1Mzg3NDA.
[4] https://github.com/damonitor/damo
[5] https://lore.kernel.org/20261121015324.83753-1-sj@kernel.org
[6] https://lore.kernel.org/20261106020559.98352-1-sj@kernel.org
[7] https://github.com/damonitor/damo/commit/9f124c1b95684065128


Thanks,
SJ
