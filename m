Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2D1E502
	for <damon@lists.linux.dev>; Wed, 29 Nov 2023 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2JEY9un"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cfc35090b0so31235495ad.1
        for <damon@lists.linux.dev>; Wed, 29 Nov 2023 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701263601; x=1701868401; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1YT23JDUOStR2+efKckGHd7K0OmUB2BTaDMNtRq3C4=;
        b=V2JEY9un/0aJippf5QziNSemoz8IZ1b0a3rWMT8tAX8as1EYLcYdcVjMfZiqOgo5Wb
         fMIR05jz7OWel3ADfWWRRewdzgoLQtftzefpZH8ribYSHqRVsAIKKRTeo2sdVrcJB7xu
         FHyTieF0kWE+B+0e4R3K4qa02dBa47QBpKfgYBd6exGns5B6FpX4YJlJFxxi6NI0Njxd
         Bqpw9MZpSuMVnjZKhgT5w7jdS47s1z2gJtHtDOp4RFxX1ZixGiaLkd1MturT8QP+IptF
         Q9dReMuDh+qnGFlvQMUKVzdLHBqaoDoOn++w8GcTGsi4OIwRmAU/h/TavX3wpMdbNaiK
         y+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263601; x=1701868401;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1YT23JDUOStR2+efKckGHd7K0OmUB2BTaDMNtRq3C4=;
        b=GhaPFgnnQ6nP0aXNc/XOsBCXjz8/0c5mE1D4JxnCKZ/K9FCvcVBsOLtYD+ivGpa1vy
         mlXudnjtT8ccRA/X43r9nQIVIFiRRganaLda69NIyJZ2IX+E+Calzlyt2C9vvgBb6zfz
         BVTnyEV4vzmhWJpet+mXf/D89ydMbgd95cOk0quqGLRc+cMQXXx1g56iLNRqlCTW1bla
         uTg/W1h+ufz2Pgk2rVwOtYwe1tQlIK/9DFHfJbBBEzT7dnGpT/5Nl8K0xyYSIZnEUMkS
         rkFe8iU18wzgjaPXB0aA1I5MGvqjKpMUQy2NSMdJnzAhoTcqeHaY/+R4MUFtgSmUPlnd
         FdZA==
X-Gm-Message-State: AOJu0Yze7s59hA3o4E2fbg8C//QhNjQtrj7ZfxjM7YMMZhypnooJDKUZ
	hZ3nI/MMPftaKH0WeZPRmY4K4S4IDgw+dA==
X-Google-Smtp-Source: AGHT+IFXMxElkHGt+LImGYb5PKuu4f0cgQnpCZoBKnnVa9EEfjK0Xu8vKDp4M5bqcmmcons7LMjGXw==
X-Received: by 2002:a17:902:b194:b0:1cf:f359:ce37 with SMTP id s20-20020a170902b19400b001cff359ce37mr5474542plr.2.1701263600844;
        Wed, 29 Nov 2023 05:13:20 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001cfca7b8ec4sm6314215plk.101.2023.11.29.05.13.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2023 05:13:20 -0800 (PST)
Date: Wed, 29 Nov 2023 21:13:15 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231129131315.GB12957@cuiyangpei>
References: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
 <20231128185739.47916-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128185739.47916-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

Hi SeongJae,

We are using damon on the Android operating system. It starts monitoring
when app comes to the foreground, stops monitoring and save the
monitoring results when app goes to the background.

The two methods that you mentioned,

1.tracepoint events
This method requires opening the tracepoint event and using the
'perf-record' tool to generate the perf.data file. Then parsing the
perf.data file. However, the user's phone is not enabled tracepoint
events. Additionally, the generated file is quite complex, and we only
need memory addresses and access frequency informations.

2. damos
There is no direct Python runtime environment on android phones.

Both of these methods provide results that are not very intuitive and
require complex parsing. We save the results in the format of starting
address, region size, and access frequency. When the available memory
reaches a threshold, the user space reclaim memory with low access
frequency by calling 'process_madvise' function.

Thanks.

On Tue, Nov 28, 2023 at 06:57:39PM +0000, SeongJae Park wrote:
> Hi Cuiyanpei,
> 
> 
> Thank you for this nice patchset.
> 
> On Tue, 28 Nov 2023 15:34:39 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > The user space users can control DAMON and get the monitoring results
> > via implements 'recording' feature in 'damon-sysfs'.  The feature
> > can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
> > damon/admin/kdamonds/N/' directory.
> > 
> > The file allows users to record monitored access patterns in a text
> > file. Firstly, users set the size of the buffer and the path of the
> > result file by writing to the ``record`` file. Then the recorded
> > results are first written in an in-memory buffer and flushed the
> > recorded results to a file in batch by writing 'record' to the
> > ``state`` file.
> > 
> > For example, below commands set the buffer to be 4 KiB and the result
> > to be saved in ``/damon.txt``. ::
> > 
> >     # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
> >     # echo "4096 /damon.txt" > record
> >     # echo "record" > state
> 
> This reminds me the record feature of DAMON debugfs interface[1], which still
> not merged in the mainline.  I deprioritized the patchset to have a better
> answer to Andrew's questions on the discussion (nice definition of the binary
> format and quatization of the benefit), and later I realized I don't have real
> use case that this makes real benefit, so I'm no more aiming to make this
> merged into the mainline.
> 
> More specifically, I'm now thinking the feature is not really needed since
> trace event based recording works, and we found no problem so far.  The DAMON
> user-space tool (damo)[2] also dropped support of the in-kernel record feature,
> but we received no problem report.
> 
> Also, I believe DAMOS tried regions like feature could provide some level of
> information, since it provides snapshot of the monitoring result, which
> contains a time data, namely 'age'.
> 
> Could you please further elaborate your aimed use case of this feature and the
> advantage compared to other alternatives (tracepoint-based recording or DAMOS
> tried regions based snapshot collecting) I mentioned above?
> 
> [1] https://lore.kernel.org/linux-mm/20211011093057.30790-1-sj@kernel.org/
> [2] https://github.com/awslabs/damo
> 
> 
> Thanks,
> SJ
> 
> > 
> > Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
