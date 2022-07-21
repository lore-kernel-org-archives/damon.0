Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01E1FA5
	for <damon@lists.linux.dev>; Thu, 21 Jul 2022 01:41:31 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso110449pjq.1
        for <damon@lists.linux.dev>; Wed, 20 Jul 2022 18:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version:content-id;
        bh=LdgplI78EYUxDeoxRkYjyZWLp8CZllSTcIINRqLdE3A=;
        b=SSr6GLm7/b+5SFA4Yrx5X603J8GBKf0m7V0HZK/zjkiM+tZLvyaubC7SCKZjZ2Ezvb
         e/Av3bQbmVG79QDH9tr8+wcSLorP4K6cU5K2JA1AcQ0SToe7NTMT3NGcZqFPzUp5R8D6
         8jjFXDm+l2Sk+qBfwygqs92miAhrD5DoiG/byf+XAlBMiuDTjVVT7xchUCteuUqKqlke
         emZc+KX+B2oqHi7+X8UojIXPOAo1soDeAjo2A/85ECt/5gXXxLCmqwhPHGklVxRS2Ldi
         U12wdAMFtyhV2jHXMAaWYeXaFwcUfmBV5LgLgLGE/x1diYkwBbXvimv05N2CtLTTHDRS
         332g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version:content-id;
        bh=LdgplI78EYUxDeoxRkYjyZWLp8CZllSTcIINRqLdE3A=;
        b=fnfzcnbv+WuBINGGJUWMXlbN7i+kb3zo/s/zuD0npqY7cbup7ebDfAEOT4+tq+Xk8H
         ES9KznF5Q7bqGr7z2A6UDOUK2SU1yLtndAYprPrPPWnJHCf+ykKTbCR+1Ti/RdlYCDYh
         Y0lyUqiExhjQ2Utnt8l+pE0p0nUNpSk6S0wcCSRzgFoobdj5J98Dr594VKWyqKYF78Os
         +Pz7FV2ZeslFvexMxF0cYDXAnsOJWgqqBKlxXZZKxZiPQ7WCyiRuhPsUqh7lkrXGVa1L
         iePfEj9+S5gCMMHyChRNzsgvne0Cv3suJboiGgJNRaB3gc9VifC0HpHwh2AsedVyeSUy
         N30Q==
X-Gm-Message-State: AJIora+ewH66d46VktkNywDU9dj9U//cmuDgkY9tcecHMIr9Pkti+IqL
	0XCJpvAwOcgUI6TT5RK0KRnHCQ==
X-Google-Smtp-Source: AGRyM1vP0YWlRwU8MUEtcSk7PKrxI6ISNJ/eI/pzhigqBMs0L7YJHcqw3ls0QoXfMg+iW3nFG8i8gQ==
X-Received: by 2002:a17:903:1207:b0:16c:7889:10bd with SMTP id l7-20020a170903120700b0016c788910bdmr40052356plh.164.1658367690346;
        Wed, 20 Jul 2022 18:41:30 -0700 (PDT)
Received: from [2620:15c:29:203:50d4:8f58:81c8:1cb8] ([2620:15c:29:203:50d4:8f58:81c8:1cb8])
        by smtp.gmail.com with ESMTPSA id 125-20020a620683000000b005252433bdbdsm299188pfg.95.2022.07.20.18.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 18:41:29 -0700 (PDT)
Date: Wed, 20 Jul 2022 18:41:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: SeongJae Park <sj@kernel.org>
cc: damon@lists.linux.dev, gthelen@google.com, baolin.wang@linux.alibaba.com, 
    xhao@linux.alibaba.com, tuhailong@gmail.com, wangkefeng.wang@huawei.com, 
    tangmeng@uniontech.com, hanyihao@vivo.com
Subject: Re: [RFC] A few plans for DAMON sysfs extensions
In-Reply-To: <20220602002935.62334-1-sj@kernel.org>
Message-ID: <7b87db1-4016-c5b9-5277-1b39f73b9c71@google.com>
References: <20220602002935.62334-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1298441060-110890790-1658364585=:4157888"
Content-ID: <f242a6e-6644-ba19-3e71-e06032314fa0@google.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1298441060-110890790-1658364585=:4157888
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <a586ffd1-5968-457e-deb0-15b560e37752@google.com>

On Thu, 2 Jun 2022, SeongJae Park wrote:

> Non-root Users
> --------------
> 
> Someone told me they want to use DAMON from non-root user, for the user's
> processes.  My DAMON sysfs interface extension idea for this usage is adding a
> special directory under the DAMON sysfs root (/sys/kernel/mm/damon/) as a
> sibling of the admin/ directory.  The name would be, say, non-root-users/
> (please blame my bad naming sense and suggest something better).  The non-root
> users who want to use DAMON would be able to populate a directory under the
> directory.  Then, the non-root user populated directory will have its files
> hierarchy same to that of the admin/ directory.  The files will work same to
> those under admin/ directory but fails when the monitoring target is out of the
> user's permission.  An example usage would be something like below:
> 
>     $ ls /sys/kernel/mm/damon
>     admin non-root-users
>     $ cd /sys/kernel/mm/damon/non-root-users
>     $ mkdir for_my_damon_usage; cd for_my_damon_usage/kdamonds/
>     $ echo 1 > nr_kdamonds; cd 0/
>     $ echo 1 > /contexts/nr_contexts
>     $ echo vaddr > 0/contexts/0/operations
>     $ echo 1 > 0/contexts/0/targets/nr_targets
>     $ echo $(pidof my_process) > 0/contexts/0/targets/0/pid_target
>     $ echo on > state
> 

Hi SeongJae,

Thanks very much for looping us in on this.

One concern would be the ability of non-root userspace to be able to go 
off and mkdir under this hierarchy.  It seems like for this to work 
as described above that root has created a non-root-users directory that 
anybody can create a directory under and then provision work for a kdamond 
thread to do.

Much better might be to require that the admin has to do any mkdir here.  
It can mkdir a non-root directory and then chown it to the user so that 
the non-root user can control it (much like a "user subcontainer" for a 
cgroup hierarchy).

> The files tree would be something like below:
> 
>     /sys/kernel/mm/damon/
>     │ non-root-users/		<- This is the new directory
>     │ │ for_my_damon_usage/
>     │ │ │ kdamonds/nr_kdamonds
>     │ │ │ │ 0/state,pid
>     │ │ │ ...
>     │ admin/
>     │ │ kdamonds/nr_kdamonds
>     │ │ │ 0/state,pid
>     │ │ │ │ contexts/nr_contexts
>     │ │ │ │ │ 0/avail_operations,operations
>     │ │ │ │ │ │ monitoring_attrs/
>     │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
>     │ │ │ │ │ │ │ nr_regions/min,max
>     │ │ │ │ │ │ targets/nr_targets
>     │ │ │ │ │ │ │ 0/pid_target
>     │ │ │ │ │ │ │ │ regions/nr_regions
>     │ │ │ │ │ │ │ │ │ 0/start,end
>     │ │ │ │ │ │ │ │ │ ...
>     │ │ │ │ │ │ │ ...
>     │ │ │ │ │ │ ...
>     │ │ │ │ │ ...
>     │ │ │ ...
> 
> No kdamond
> ----------
> 
> Currently, DAMON creates worker kernel threads called kdamond and does
> requested works on those.  There was a request asking the work to be done on
> the requester's process for easier resource usage charging.  For this, we could
> add a new directory under the user-specific DAMON sysfs root directory, called,
> say, self-service/ (again, blame my bad naming sense please).  It will have
> files similar to the contexts/ directory.  Then, DAMON code will run on the
> process that writes 'on' to the 'state' file under the self_service/ directory.
> 

For this, the sysfs interface might be getting too complex.  We can 
imagine hundreds of files that userspace must maintain to implement the 
full scheme of how it wants to use DAMON.  This allows it to be very 
configurable, but at the downside of a lot of complexity that must be 
managed not only in the interface but also in how kdamond must be 
implemented to support the various combinations.

So I'd definitely recommend that all possible tunables and configurations 
are indeed necessary and have real-world use cases behind them that are 
*generally* useful to everybody.  In other words, hold a high standard for 
trying to add more tunables under these directories because it becomes 
very hard, if not impossible, to deprecate this support once the sysfs 
interface provides them and userspace depend on them.  Something to keep 
in mind when extending this interface.

> For an example, below files tree is imaginable.
> 
>     /sys/kernel/mm/damon/
>     │ non-root-users/
>     │ │ for_my_damon_usage/
>     │ │ │ self_service/			<- This is the new directory
>     │ │ │ │ state
>     │ │ │ │ contexts/nr_contexts
>     │ │ │ │ │ 0/avail_operations,operations
>     │ │ │ │ │ ...
>     │ │ │ kdamonds/nr_kdamonds
>     │ │ │ │ 0/state,pid
>     │ │ │ ...
>     │ admin/
>     │ │ self_service/			<- This is the new directory
>     │ │ │ state
>     │ │ │ contexts/nr_contexts
>     │ │ │ │ 0/avail_operations,operations
>     │ │ │ │ ...
>     │ │ kdamonds/nr_kdamonds
>     │ │ │ 0/state,pid
>     │ │ │ │ contexts/nr_contexts
>     │ │ │ │ │ 0/avail_operations,operations
>     │ │ │ │ │ │ monitoring_attrs/
>     │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
>     │ │ │ │ │ │ │ nr_regions/min,max
>     │ │ │ │ │ │ targets/nr_targets
>     │ │ │ │ │ │ │ 0/pid_target
>     │ │ │ │ │ │ │ │ regions/nr_regions
>     │ │ │ │ │ │ │ │ │ 0/start,end
>     │ │ │ │ │ │ │ │ │ ...
>     │ │ │ │ │ │ │ ...
>     │ │ │ │ │ │ ...
>     │ │ │ │ │ ...
>     │ │ │ ...
> 
> 
--1298441060-110890790-1658364585=:4157888--
